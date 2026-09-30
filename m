Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385BB51DE0C
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803492; cv=none; b=kU1GgN7uNJh8tOl2+VnAA7LTFp6BLiGELeKcAo/SD7ZLFwVFCHjs35o1iPLhpxmJe64qm7Gv1lLOcRwIVJdJGMsD3DW+Z4cOR00a031qryykJ/S6cnl/ETELCVRTHIiHpIpaIPEzenq+kq+SEQC3HDKdqfw7yQsSrrjEGfi6bRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803492; c=relaxed/simple;
	bh=73U2fsAxNg7JPXuaFc1XZRdPWvgkLx0TsEouw4Nf8os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a26L2Pd0v0z/74k72nn/Zg5wsZfo56Gg8dT+FDv79vi+haZDZ9iixuevACI6bz7HLvq8pK157Hj5uSkJ14Zox/F58V7TO8zTU+G5GHbwkpY4YSyo0icknFSiW8ea3pLy4zsRBSD1qh0WBgOjvpzXWkjrRZb9eC7Kp8jM4LK7e5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cb5L51cI; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cb5L51cI"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc7c058617aso1352595a12.2
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790803490; x=1791408290; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H7kxKVmQyn0odAFFtPbM4RSi32dD79a5EtnalGn7XCs=;
        b=Cb5L51cIPRHfK3yzMYBFxHTkdliIStIPw+OEMWY+qmrylncpgIo0ZBO/B4RMweNbcP
         XtT/OujqKzDVa+fKKMNL21bRspzTHW2yfoda+IR/6Itw5VYuHBOsHg38xk6pb7xZXgtY
         OzlONXc9E0TkTayc4JeN/TFCPyzplISb+Wv6kX6LFddnh38ZW3CIO+u3SAS554bzS+or
         0dDYzLZa8nC7wMAS1kg2cOPfsWh0KhwREvJ8bGNOmDHoo9pkFmSWHuDaMWI7WPQrNjTs
         dhp0rncgxl+MKkqXDGBsTeOQ7gvZ4z2TbQfAgSZmy5bD82ztTc6aed4McEzoSyCJXM7S
         hpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803490; x=1791408290;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H7kxKVmQyn0odAFFtPbM4RSi32dD79a5EtnalGn7XCs=;
        b=ifCrvDfDVJMBp14ACiK1BEVj7bIDZ9QB+Gbfk9YcEhCVAzAt0tzklUcfYdQCcKLwSf
         VBEOvdzX0T3+1tMP0WaLZFkFv0qtvesDVescm85kVyNpBmf5AsGP6fh1fZajUNMf8TRR
         usjTyOpC6mrllCcknWVvAWA399Ep6LivIPCaOrVIwbeOpY2pNI2oiIEh8o31dps229zc
         7FiM4JNk4nhTQOmNJBSiK+1TBWh4Bo6Srbukiy4a7Qi+vDU3/K/cf36FZdMtUF2ar4jC
         joV8Fim6/oqSa07vHdu+7LUw0l6WIt+zYy7LUXwmetaLNCEIEl/zHPt43WoD/TjMkIRC
         IQwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQMnqVPzhTCr/ZhCKGXaxg9Rxx2TdSxf0cNdWkK+hmsMjAj4+oT5sXS0TOo8bNFesnr/k=@vger.kernel.org
X-Gm-Message-State: AFuF++lVzPtKA+l6koXnRglWbJHIS7Uh32SyVBdjSFbd1SLljdGMc+Ku
	0hpo27Y/hNN8hvvjgbEWLACjgLlj+vRPJCst5ZDC16NdrA21LPOr4tUUbcaVx/RzwK0=
X-Gm-Gg: AYBFou2qsbXm43uQUS7pdsD/0Gba/IaVRx5WYWRmonRlQAtDP4Pq/iu4Ru2zq4YYInn
	D+rHjhKEMM9jy6FcV0etbgpdFctqvw2v7Z6OWdxLiySWKNqzSXwKbGpPzv6jbECDkSKwecDlIZw
	Tx2qsY5VuKboeTTETFUYLFycrumqwdRj1v7sP+gKfmstLZRIbZtuEc2beh8mYrxJpmlM5r9Xx/z
	3BFaz2gdaIEr1cnCYSc5DJBTd3+9V5YYpBEAVUw1/cXwKorv25rdYDptyf7fkD41nCVUkNuAI9u
	FY0iad0+jtv8XHftDNLIrf38UG+yVYvIMkqhhrc/t5Xcal0EZEnId7b4cN+eid+UFpgvtpaJYb6
	hCsNzXrlA43dg9j5NTV43o2j+Voja/gMhwl58PQ+51bb/XtAQgMfM7R4fuw2MNZC+mC/mevMFo/
	9IMM3P0wDmsinlPNCRo8t5nHuZ4Z98v5LeQLX/D1FnC7/3bRA6pIH9LeS6G4ond9S0qAhZJFH5
X-Received: by 2002:a05:6a21:4e01:b0:3d1:39e9:b261 with SMTP id adf61e73a8af0-3de9dcfd17fmr2343533637.0.1790803490226;
        Wed, 30 Sep 2026 14:24:50 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:f5b4:4d0e:70d:9fba])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7e54c0be3sm423609a12.30.2026.09.30.14.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 14:24:49 -0700 (PDT)
Date: Wed, 30 Sep 2026 15:24:44 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Michael Roth <michael.roth@amd.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	gshan@redhat.com, enju.kohei@fujitsu.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 02/24] target/arm/kvm: Return immediately on error in
 kvm_arch_init()
Message-ID: <ar1-HJ-5QzSvcJUS@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-3-mathieu.poirier@linaro.org>
 <rocrppdlgvg6jcolhnlt7z7ilqmthepim66ujg4e5diayw2gmg@s345fbhx3sov>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rocrppdlgvg6jcolhnlt7z7ilqmthepim66ujg4e5diayw2gmg@s345fbhx3sov>

On Tue, Sep 15, 2026 at 04:01:06PM -0500, Michael Roth wrote:
> On Thu, Sep 03, 2026 at 01:35:49PM -0600, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Returning an error to kvm_init() is fatal anyway, no need to continue
> > the initialization.
> > 
> > Leave the `ret` variable in the function scope because it will be reused
> > when adding RME support.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  target/arm/kvm.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index d40a6a985914..ed99be7fd80c 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -596,7 +596,7 @@ int kvm_arch_get_default_type(MachineState *ms)
> >  
> >  int kvm_arch_init(MachineState *ms, KVMState *s)
> >  {
> > -    int ret = 0;
> > +    int ret;
> >      /* For ARM interrupt delivery is always asynchronous,
> >       * whether we are using an in-kernel VGIC or not.
> >       */
> > @@ -618,7 +618,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >          !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
> >          error_report("Using more than 256 vcpus requires a host kernel "
> >                       "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
> > -        ret = -EINVAL;
> > +        return -EINVAL;
> >      }
> >  
> >      if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
> 
> There's a error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap")
> under here as well that doesn't have a return -EINVAL after this patch.
> Is that intentional?

This patch did not touch the clause that checks KVM_CAP_ARM_NISV_TO_USER.  As
far as I can tell, it is mainline code.
