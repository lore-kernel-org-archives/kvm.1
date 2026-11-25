Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621838;
	b=be5VrtvNV5ijGhCh2ykfXy+pzWoUop86ziUo/oW4GFfV8o1ZdzEFQ/ehN2uC4VweFg3Q
	 opYmj1szt4WEBFp6lzGPdH6s9sI8huMDcUDLG+rm5gVrT2MVn0HEMIi1aVwak9c6vc1t8
	 jBKfyJRbXEpktmdDp2xNMN4e55PzptD82HahuoBD47T5iP7oomZ3X1wA5FKKBRjQzDh/i
	 OaFVnCPW68vnC/o6bB1sbcrT7cQFj9Dy9AB6q20UKpBh3mQeOR6zdjnKFTy9qhQeco0WZ
	 RctUGK/kLVpcEm0VFiDUCM/d6tLmAZlFLdhcOGhXJPLWh9rLMI0g0sXlSiGW/n5KYrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621838;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=JOVihf8AZVCZu2Aw4tH3FyKABP4IPNDzRcD+p1XLuhQ=;
	b=nvdMbdJMVaL+iEW58O7CdkSxJ3/c96z1FenQU9c1G+CNW6X/XoLMFKvisjgg8+pq38v7
	 VRAODAqUPLkgZAR3noM2LPG5b0jEFwQh8SejMRaoNqRZm/Gs7AOEN6SBB9qgCBeqBaoch
	 Q/8Rg4Y3GKsYmItMUyLDIyf/sTk/Y/D3c2H3sbznvk78S39fOBwHSRz9/PYmOFlLR8AyW
	 xUI/mZ25N8ma3iXw4pMp0MAKZvPAAK8QFlI+ozEiE6WnTn6qwshILcz2Rs8UTRCU3WX4F
	 18ysOItaIJVLcA8jLKYtPnEGHtoUqv35x5wsvbm6e/F83ok0+gt2e6dQJtHVqYcbblg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nnzpdv4a;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FFE606A335
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76FFE606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nnzpdv4a
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF45E2F;
	Wed, 25 Nov 2026 07:50:31 -0800 (PST)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 366B43F86F;
	Wed, 25 Nov 2026 07:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795621834; bh=3GXsX9Ej2LOPIEboRLqmNRTGHxu2WQYYYsQFaNYp5PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nnzpdv4a7edEwDoby/SAe1cCObZrbza1z5Uv2vVHjkcORf4t0MFuVhBElQK25OB9S
	 jsyrbmyqaeu43wvjJbZkCpMYMl7dZi5PTu8xZziTyAKzErV1kv3laReYhAPdJ+01A4
	 7yNbCFhBOGJKRmzvHKPvU3Pt8kmLeZF2xNh+xGIk=
Date: Wed, 25 Nov 2026 15:50:21 +0000
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>
Subject: Re: [PATCH 1/3] KVM: arm64: Add enum support to idreg sanitisation
Message-ID: <m45vlff6a5pyza3enol4uebl6uixcfjqmua3mg3eq3jaqujjev@sbaxsxeedrxm>
References: <20261123192457.8700-1-maz@kernel.org>
 <20261123192457.8700-2-maz@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123192457.8700-2-maz@kernel.org>

On Mon, Nov 23, 2026 at 07:24:55PM +0000, Marc Zyngier wrote:
> While a good deal of ID register fields are simple booleans, simply
> indicating whether a feature is supported, a number of them are more
> structured and indicate a level of support.
> 
> Reuse the existing framework in a nested way to expose which level
> applies for the current configuration. This relies on the levels
> being ordered from the most to the least capable, and the fallback
> to have a NULL callback.
> 
> Yes, this is pretty obscure, but the following patches will make
> this clearer (at least one hopes...).
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/config.c | 44 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
> index cfdb6c7133204..40965513ebacf 100644
> --- a/arch/arm64/kvm/config.c
> +++ b/arch/arm64/kvm/config.c
> @@ -28,6 +28,7 @@ struct reg_bits_to_feat_map {
>  #define	REQUIRES_E2H1	BIT(5)	/* Add HCR_EL2.E2H RES1 as a pre-condition */
>  #define	RES1_WHEN_E2H0	BIT(6)	/* RES1 when E2H=0 and not supported */
>  #define	RES1_WHEN_E2H1	BIT(7)	/* RES1 when E2H=1 and not supported */
> +#define	IDREG_FIELDS	BIT(8)	/* idreg fields */
>  
>  	unsigned long	flags;
>  
> @@ -40,6 +41,7 @@ struct reg_bits_to_feat_map {
>  			s8	lo_lim;
>  		};
>  		bool	(*match)(struct kvm *);
> +		const struct reg_bits_to_feat_map *idreg_field_deps;
>  	};
>  };
>  
> @@ -73,6 +75,13 @@ struct reg_feat_map_desc {
>  		.lo_lim	= id ##_## fld ##_## lim	\
>  	}
>  
> +#define __NEEDS_FEAT_2(m, f, w, dummy, deps)		\
> +	{						\
> +		.w	= (m),				\
> +		.flags = (f),				\
> +		.idreg_field_deps = (deps),		\
> +	}
> +
>  #define __NEEDS_FEAT_1(m, f, w, fun)			\
>  	{						\
>  		.w	= (m),				\
> @@ -95,6 +104,11 @@ struct reg_feat_map_desc {
>  #define NEEDS_FEAT_MASKS(p, ...)				\
>  	__NEEDS_FEAT_FLAG(p, MASKS_POINTER, masks, __VA_ARGS__)
>  
> +#define NEEDS_FEAT_FIELD(m, ...)				\
> +	__NEEDS_FEAT_FLAG(m, IDREG_FIELDS, bits, blah, __VA_ARGS__)
> +
> +#define ENUM_FEAT(e, f)	{ .bits = e, .match = f }
> +
>  /*
>   * Declare the dependency between a set of bits and a set of features,
>   * generating a struct reg_bit_to_feat_map.
> @@ -1456,6 +1470,27 @@ static const struct reg_feat_map_desc *idreg_feat_maps[] = {
>  	&id_aa64mmfr3_el1_desc,
>  };
>  
> +static struct resx compute_idreg_field_deps(struct kvm *kvm,
> +					    const struct reg_bits_to_feat_map *map)
> +{
> +	const struct reg_bits_to_feat_map *tmp;
> +	struct resx resx;
> +
> +	/*
> +	 * Assume the enum values are ordered in reverse order of
> +	 * capability (from most to least capable). A NULL callback
> +	 * value indicates the ultimate fallback (not implemented).
> +	 */
> +	for (tmp = map->idreg_field_deps; tmp->match; tmp++)
> +		if (tmp->match(kvm))
> +			break;
> +
> +	resx.res0 = field_prep(map->bits, ~(tmp->bits));
> +	resx.res1 = field_prep(map->bits, tmp->bits);
> +
> +	return resx;
> +}
> +
>  static bool idreg_apply_deps(struct kvm *kvm, const struct reg_feat_map_desc *r)
>  {
>  	struct resx resx = {};
> @@ -1463,8 +1498,15 @@ static bool idreg_apply_deps(struct kvm *kvm, const struct reg_feat_map_desc *r)
>  
>  	for (int i = 0; i < r->bit_feat_map_sz; i++) {
>  		if ((r->bit_feat_map[i].flags & CALL_FUNC) &&
> -		    !r->bit_feat_map[i].match(kvm))
> +		    !r->bit_feat_map[i].match(kvm)) {
>  			resx.res0 |= reg_feat_map_bits(&r->bit_feat_map[i]);
> +		} else if (r->bit_feat_map[i].flags & IDREG_FIELDS) {
> +			struct resx tmp;
> +
> +			tmp = compute_idreg_field_deps(kvm, &r->bit_feat_map[i]);
> +			resx.res0 |= tmp.res0;
> +			resx.res1 |= tmp.res1;

This looks to me like it just forces the bit pattern of the most capable
enum value the current configuration supports. So if the user sets
something that is different but less capable we will just raise it to
the most capable value, is this what we are going for? Or do we only
want to sanitise it when it is over the maximum allowed value?

Thanks,
Wei-Lin Chang

> +		}
>  	}
>  
>  	val = kvm->arch.id_regs[r->idreg_idx];
> -- 
> 2.47.3
> 
