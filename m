Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B342C4F4
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785348405; cv=none; b=gTNpnfnMtA6q+qOzAaxQ98c9RwsCLQwOBUti+Dct6u9rReUP6gjRyUNw76cw/jdQttbcCNS3OBWfx8Vb/muAOW5QT63EyaBeU7Y5wdq5dWGO0zMFlc8FK4R87YmZzasWL1tcG6b8fHxRf0BSAIeN1VO0fas+CeuCkYLCiaRkvnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785348405; c=relaxed/simple;
	bh=awd77f5bif/dIgyPxCs6KSL0oviQPYlUuXl3UA5EPtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMichkz7Ki3f3bZIWdyYJKywg7QLJBMT8NjHlw9uBhKHriGxP+G7i4u1CUoDlRShifFL4CHxE3vIhx2fq4VIqPp7JfK0XdruqgkHf411tGuldIIgcAQyT0hzZ9XeH3LrISDXGNN0IjK7nhrCVVbeqyMYyhe9igm1Uw5Do8ndE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pgqtt3iY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pgqtt3iY"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47640541585so981929f8f.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 11:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785348394; x=1785953194; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+yaJ1hCjUBCmis82b4ussWNf6EXlhg+aBQ8DtTvotq0=;
        b=Pgqtt3iYQBFWEiFoU6UiHcgTeBY2FPWJVikCRqrXhUhCxRd9kJAmxhQdkBJTK1heYB
         rBYd1BbPrQI6cHh0NjMuHYoYhNveiySY10Kf0m77z5YhXSd1ORgKsPGOq2J1VBQp3U7X
         ulqkhmp6mWILLTUdT3BSzXSiQbJM70qEvfz1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785348394; x=1785953194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+yaJ1hCjUBCmis82b4ussWNf6EXlhg+aBQ8DtTvotq0=;
        b=avfjU3oEWV6MfgX+lYsDAXrv8SP9Ugo/yBcay6vfdEFxFIHnbZHvP22R7Nc5om2829
         FagvkLVGzLvYnfmzRj22KeIp+aYPfOtQrjB0dM15uNFPuAjytp/Vr7FRjcedVlfYHg1/
         ryadPb83zTGpdBZWvsQvcO5rxRIk8r41o6A90w8hr7OTwrG/AC5eouOD5mMQgObW5YmH
         xdzoL/JbOhtmjDR+ya2rVgDSoQPO+roS/Z1mubQP+lSJSXVQuoGIWh0IT4h+uV8tc33/
         f/zYu5J0WsQbRRubivh2fTMtUOXHJAqqTDyJhAJJLeebKO0/Go0zcbRtK5ZRXQ69Ilmg
         Jsrg==
X-Gm-Message-State: AOJu0Yz0jtTlXHwLLmI64nNu3z1XFciT31omHCrZA9qVGYecGEQ4Z6O2
	XpAA9u7GegS2wSFVrl40CJ+7DL+rfA+wpDBvnsx3uBL1YViFArIhhve9plRcfNkxbb48RvhiAz2
	TR6gcSw==
X-Gm-Gg: AR+sD11eiDngBSBBF6JNB7ke7Gqgx7Exwg+ep+LHHQhwlNTunI+TqDhibSGZJhI+Wi2
	DQ1khWALmLDSxs5Ky0jBo4iETwaGBrbGHEm+rH6ixO6CgvebZNFEVtTdePA3RNVCwucwagqUfaw
	Qg+HEqvRe7RHNElKd5bTOjW6sznTXbdgRTotSlFptPx2U3Da+hdRGN3SzCzWUkavju+FqAw6ra/
	uGyX5X3mqITfpZMlx+SEWlxNd6hZYoHL7zp5pUN9gRAeaolvrt0vR0L8Yt6qV0wrlrnDccavAEv
	+q0Y/+3vhTmqgcInq5YB1TYouVphrGWIDUErGvG5kdARp3HXRkExcDt0vJPHbWpbAT1hYoMHeuT
	7UP5QUsC73maIeT/MkQfAjC/3wi1iRNd2C9vrvAdGKfDSiNqhXgVa09FV3jgCMI1EDvAKrSG9le
	EXqLWZs4VgfejyA2C8ClSKYw4VBdPiD6k0qJLT9SVVyQ3W5QmSsCgSJbaQMVkmo57jEuGPnIkgz
	ROWdoKd6n9y9PwPlLFirg==
X-Received: by 2002:a05:6000:430c:b0:47f:9201:6409 with SMTP id ffacd0b85a97d-47fb1f17008mr8860822f8f.40.1785348394087;
        Wed, 29 Jul 2026 11:06:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:285b:8:6f8:f7bd:339a:29ca])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0f039sm10526768f8f.18.2026.07.29.11.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 11:06:33 -0700 (PDT)
Date: Wed, 29 Jul 2026 20:06:30 +0200
From: Dmytro Maluka <dmaluka@chromium.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] KVM: VMX: Fix stale PID-pointer table entry left
 after vCPU free
Message-ID: <ampBJrSSas_XISim@google.com>
References: <20260729170621.308809-1-dmaluka@chromium.org>
 <20260729170621.308809-3-dmaluka@chromium.org>
 <20260729172831.5BDE71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260729172831.5BDE71F00A3A@smtp.kernel.org>

On Wed, Jul 29, 2026 at 05:28:30PM +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 6b96f7aea20bd..ebf26ea84a50b 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -7572,6 +7572,9 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
> >  	nested_vmx_free_vcpu(vcpu);
> >  	free_loaded_vmcs(vmx->loaded_vmcs);
> >  	free_page((unsigned long)vmx->ve_info);
> > +
> > +	if (vmx_can_use_ipiv(vcpu))
> > +		WRITE_ONCE(to_kvm_vmx(vcpu->kvm)->pid_table[vcpu->vcpu_id], 0);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does clearing the pid_table
> entry alone prevent hardware from writing to the freed pi_desc?
> 
> According to the Intel SDM (Section 29.1.5), the processor caches PID-pointer
> table entries in the VPID.

I can't find this statement in the SDM, and I'm not sure what it has to
do with VPID, apart from the acronym similarity.

> Because KVM immediately frees the vcpu memory into kvm_vcpu_cache after
> kvm_arch_vcpu_destroy() without issuing a cross-vCPU flush (e.g., via
> kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH)) to invalidate the VPID
> caches of other running vCPUs and synchronize with in-flight IPI deliveries,
> can other vCPUs still send hardware IPIs using the cached pi_desc pointer?
> 
> Could this result in the IPI hardware writing to the freed vcpu memory and
> corrupting another newly created vCPU when the memory is reused from
> kvm_vcpu_cache?
> 
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260729170621.308809-1-dmaluka@chromium.org?part=2
