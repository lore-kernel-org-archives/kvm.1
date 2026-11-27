Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767253;
	b=s+3cdk+pk+K/EuN5u/QyUXS1kEPygD0ICVr1inGfHC6DM5VEkdAHsQVpJoTM1ZSIT7IU
	 9q7w3AQs3CR2csNwf4URcbDo2R0Srt4Z6R0lsvHTAH9j9YRebJ5Ebz+aj9ADwhqp1la9Z
	 9J9VCgi6t/cFvc2vuuO7Wn9BOqt92siuZl/i9jaSMKij6KpZQMsn9uEQ0gwASVY8oIsHD
	 2NkIXxvk4WhN+gkzD/Ets23mDGLoGF7U/l/J5h5FdLMyvg9hne5FLIQqlsWvA5ELG0WQS
	 6kAkNDpNuJNA4AWSGZBP5HNRBf0Mt+Rh8fIkkRO1JMwQ8VMeXAYb5wg408Zn179SNlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Apk+wF3JIOKu8ET+h25TVTVOKsViveOnjA4s7dlaLmI=;
	b=YKXvqF8RfUKBDcTbpArgNIwb3fNzEpcavyncFNCyxu0zrVijUXiQCxspwQ9+GSrgRBF9
	 vphhRE19oFJ6WpHa2QdY//WvDfTcbJ6Yktjdkrlxu2k8j+GaSFopWNmBk3L4EnorfAO9o
	 iT+Uh2oyfaq7B/V2rvpRo3sZ4+Z+E8BuG2udvDGBjNOV4eSS4NgliVHVDrj0VAXFJkkhO
	 pMMb6jh6k2S0hylbpCqNMa3sYlKc19cyl3urtDgfsGk2gvYUdBliHtUA2bY5ITNDv38TX
	 62eSoML8AY3NMW4PemtG616pP+PpVY26eVWXZ/DxKuHy+xE1id+GW+/gyAMn5FHiVmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=HNykBpZ9;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F32606A32E
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 08:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9F32606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=HNykBpZ9
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a358881793so4091255f8f.0
        for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 00:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795767251; x=1796372051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Apk+wF3JIOKu8ET+h25TVTVOKsViveOnjA4s7dlaLmI=;
        b=HNykBpZ9lfDZ6DhkWul/RuWg4e+BI3d9n3GfSA5/T55zTWK0akpA0ci7MAANxVvVtT
         Nv7j1KG+8PGi53jMaywhLBRQoNLPrPLmKLA0mYub1lmasjUqGVAkSRz3IZSRrSlNFJmz
         5mqtdMUTOO70QBMqnf6aoeCC5mcUrtRWZN+G7wruwTl2I+3H3yrCcdEDC1VIMmZ2BTPo
         /Xqc1EGDyzLWNzLgifhPNMh/ozZ5IEJtcjWJyL/i/SFjW38zUCXn4BIKfi/5hFbCcGCg
         76amD7xZB1j1EgecELK4YE+72/bXOw7eeW9qFCXsJTZAezbdKAySB3zsnvXlkzC4m/E6
         KQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795767251; x=1796372051;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Apk+wF3JIOKu8ET+h25TVTVOKsViveOnjA4s7dlaLmI=;
        b=CH/eMTFDnf0cD3QzZ6cBxp0j5EWDaN3R5rSts1S44jNJwghmQ4ClrFqhq3YP+iFYjb
         YqBSXaxXb0KNh7DPBggbEzeFuHlrvojb3R01UOONSqihruyeSgN1OAHsEDIH6lZAvQPJ
         0z/U59i6AucHWd1h06+7yeqpX57gddBrXvrNmG3bu56XKBLNGsmH4bMcu8IvewHEcI+x
         Gj7sTuJGxW/220Z4N+6Iu04+/lVvG+mKC6n/WjezPe6NtMqPasbSvZqPiwjkIg6wvFVO
         KeaFZJsh7U0rU8zuyPr0YpzITnbCt71f+/aP2C+YrUfhoTnS4sFhVbfl2uEEC/50rjbL
         rhNA==
X-Forwarded-Encrypted: i=1; AL+hErEn4tON3bVKThhPPDlzqf7SvherFvwgDYXU5b56Thz9OlzOmR/p//cq1AWdrJ0XKWutH1s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CSpuLqlWEVAnFqWG6bG6mxb24IorPSZL6C3e2CtugYZXrwIL8
	ume7ZwfT1TCoAvSGlKkTbpGlbHl0j6Tv7gCeEhu6+0PAXivyeFDsnize/4xhhAdmr7E=
X-Gm-Gg: AZFdTZeIAwrJEhTMdXoSV44Qr8r0omud1VTmxdbyeztc+jagvxa+BH33z+Koa2PnYcc
	Tn9DaAcfGUmk63MWajG2tq5Tcw9wg2D5KBNMQV5GUiTg4cHoJBfDr7+/RXyH5KnN+W4bQ8ycRE7
	6XC7w/kAuPkWpkshSRw63wLUwSDcVUfWe3CYgXVJEGj90bloMEJfk3k0FXmvr1Xt+uZ/gmrLyDf
	pHiERzaT2Tmq9Uu7xC8QLSYbuD5WmxztH99jhWTZmTkmCQRNFOexSn68Q96qeY62fvaikAm2sMK
	Xe4vbwDxlkWsPc182WyNV3fIAAIcB/VlSopaBxcWEpkz3qX2Mls35LFr9lu5w0APWdMk83AiN4T
	Rj3Fw34zBp/t0RB3xid0u8PgQIa4Rma5mxDYSmAetkfqMU5wCBMTILGjm9jKZdaaEJiZJOwccxF
	gjWvOiHlVPIqrGJ2NVnP0O7/rsW8CRIscEthxs6cIrjdzWwu6COLqA/yAa3p80y3iHTo9sfFXvQ
	dPQHf9RprEUF01HEEJWkoeYkNw3XU88Zo5Vp991elWSf2F1dSwbjzp8VXyQL/OkrC4vtMv2eS2L
	MYb8aUu0Hqp1skHcM6k=
X-Received: by 2002:a05:6000:40ca:b0:4a3:976e:27a2 with SMTP id ffacd0b85a97d-4abb5146238mr46038597f8f.34.1795767250897;
        Fri, 27 Nov 2026 00:14:10 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm52271979f8f.24.2026.11.27.00.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:14:10 -0800 (PST)
Date: Fri, 27 Nov 2026 11:14:07 +0300
From: Dan Carpenter <dan@pereq.eu>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Karthik Bhargavan <karthik@pereq.eu>,
	=?iso-8859-1?Q?Cl=E9ment?= Blaudeau <clement@cryspen.com>
Subject: Re: [PATCH v2 09/16] KVM: arm64: Report faults from S1 walk setup at
 the expected start level
Message-ID: <awk7z5-ZlzQDqfcz@stanley.mountain>
References: <20250915114451.660351-1-maz@kernel.org>
 <20250915114451.660351-10-maz@kernel.org>
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
In-Reply-To: <20250915114451.660351-10-maz@kernel.org>

Hi Marc,

On Mon, Sep 15, 2025 at 12:44:44PM +0100, Marc Zyngier wrote:
> Translation faults from TTBR must be reported on the start level,
> and not level-0. Enforcing this requires moving quite a lot of
> code around so that the start level can be computed early enough
> that it is usable.
> 

[ snip ]

> @@ -351,12 +351,17 @@ static int setup_s1_walk(struct kvm_vcpu *vcpu, struct s1_walk_info *wi,
>  
>  	return 0;
>  
> -addrsz:				/* Address Size Fault level 0 */
> +addrsz:
> +	/*
> +	 * Address Size Fault level 0 to indicate it comes from TTBR.
> +	 * yes, this is an oddity.
> +	 */
>  	fail_s1_walk(wr, ESR_ELx_FSC_ADDRSZ_L(0), false);
>  	return -EFAULT;
>  
> -transfault_l0:			/* Translation Fault level 0 */
> -	fail_s1_walk(wr, ESR_ELx_FSC_FAULT_L(0), false);
> +transfault:
> +	/* Translation Fault on start level */
> +	fail_s1_walk(wr, ESR_ELx_FSC_FAULT_L(wi->sl), false);
                                             ^^^^^^
Switching this from 0 to wi->sl was obvoiusly done deliberately but Pereq
is trying to do formal verification based on reading the ARM docs and
matching it with the kernel and the AArch64.AArch64_S1Translate() pseudo
code uses a zero here.

>  	return -EFAULT;
>  }

Part of the issue is that wi->sl can be totally bogus.

   274          ia_bits = get_ia_size(wi);
                                      ^^
ia_bits is based on wl->txsz

   275  
   276          /* AArch64.S1StartLevel() */
   277          stride = wi->pgshift - 3;
   278          wi->sl = 3 - (((ia_bits - 1) - wi->pgshift) / stride);

so wi->sl is based on ->txsx and the "- wi->pgshift" subtract can
underflow.  We check txsz if is invalid later "if (wi->txsz > 39)" etc
but we still end up using the original "wi->sl" invalid start level.

If we made invalid values of ->txsz use zero that would fix my test
cases but it still wouldn't match the doc.

regards,
dan carpenter
