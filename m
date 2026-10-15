Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B4D3E717C
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096271; cv=none; b=UVFtBq7Ssn7ZrRneBCUskGnR18VZUm6ypewKOD8Mk5lUQicz4FGGOdg9K/x6x2pguQuGWKUUQS0idYKjL42ChcURindXPCKvxq5CZTrZc0bZVHLiBCX6sDNN4PtBBOxLMPD6EAm+iESQALSBDt4dYXCojMkdpHF2TCqQLTssOHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096271; c=relaxed/simple;
	bh=EPg7AH5MWIORZwLxhs0lMb3LlTkslRaotabgYUK7CTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxKWUAuZyy1OqY/NHIZnxhtJnq6c1cBAc8mISy3OcLs0HzxhsInwcGvmXoNzDWVQ+xdZZNdnYB2hWpWvB6aJac7heVotPyHYGi38/qx/xeufhUbj+Xg7rk6nkwCsFm0CDU9kcJEFAVIp/Uar0ubWROgprzFA8C2oMWf+979EzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AhZoOj9v; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AhZoOj9v"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-886e61fa30fso2191653b3a.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 13:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792096270; x=1792701070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pBnzENG+hypG+KwtFE6xg5OmepbVILPhdpggt/oBR/M=;
        b=AhZoOj9vQt0ubQWyfiMs/37+GzGyQTTHayNPybXhvVZmyTqdrnDzSdVlIhxLRX/1r2
         cWTw4LJCQG5otBOUQ1BjQZuExsk+TZjFNf960nE+7uGLHjMYbbPofICgFcLG6d4tUf/4
         5a7Uv1yuZyJ6O69ku8g4mNTV5LunTBq6IPcpELoe+rBqVzo6VS6+9qt/JUMguzHEYlkb
         x/vLVX3pcIm5rrYEXMWgZqbBgH7KLtO7AySAMMqF72QLgK2meOc2An81MvuxeA0KJyeG
         ssmTZXLmNHoMbHcoDBft0DqKojT/ki3gOe+XZUAnVG1379MlMrHNxogERD0v4Xv8J9Hp
         0Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792096270; x=1792701070;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pBnzENG+hypG+KwtFE6xg5OmepbVILPhdpggt/oBR/M=;
        b=vusUxyFohF4NyfCmr41nxCRCVy2tvMoKt87Nu69P8eIMPiqVy7ZDJG+S1IG+MYTKob
         ctKQZmFleU3TFrIe258ghVcyAhCqmyoCAnX1fmhGVuAz3AfKGbyXXdPYsw+BQ/3xHIfq
         9eboQ/sei3C9GZtAtP8lsPxTbAKU1Nta3d1Cr0KRvovfraeXV0kCl3bLe0e6HNsIffdW
         QZ4SmXwdgkHYC91n5MJuwQAdX65eGEIhA8jtbmb/H0i4Pt+PibUTapVFu39aE8gaUgX2
         lmErn97Ss15XN6jQpUdbIS7g19qHxXQ5lFDeFfG5+ZJRwDzrRQZdwvzQwmhRFgISRDYv
         S57g==
X-Forwarded-Encrypted: i=1; AKwUvBw47G6GCyUpOUYYspMlZ4kxSS1zM57DMlWtPwta4GY3qYy1SYzAm3Emc4c8NfA1Eebd8Ic=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkTcer73KblK4BGKIYuO/GLMF6OdB3T9tDxSvDM6F8/5RkS9av
	EJaxeXiKEOWqIQNyuC3pV+F1612cK6Glmi5zk7YYm6eEbQwmVON1ytAg1UJJ9sOS1Gdso+c6ksb
	9/oEN
X-Gm-Gg: AYBFou1u/iG72ywGdppF3Giyogw5vUhO+4viKL3NhMWAUAj1EVgLlz1I3f1e0zVGGeP
	TVWiyxEefE3vQq2FXtKi87YKATVZp7NaHN5YWfcKcP0eUd4sgPCRQkwkS2/49UPwQViG57+GAEK
	ClDupfMskerBb8BeQQwXvLJGKndK44muwu+yNLIIVn8PtOTrFbtY1K3D3YyEIt7URAINOEtQ8O4
	mGzHDzqNPRHxCq/uVKmpDNbtzfmAzNrdX/vnxEfbRN+bHrllKyUtF5FdhWihktlAu2KuWfp9wh2
	bN8uH47Wwsadogz5hv+w35C83MqrSymWSzQMouJ+OCwNP6I35hMpnC9mBcTFmHAg+nFVTPo/JN0
	wgouILidxzirhM0jGMCVG1ea1sfrXknfVtBirdNCwN8nDKHGQXtkBRZx7b89AA10gWmzEWRxCRU
	6FnQ4AUrCbBa3Y0Z0ZOhWfibVRF/dLruNOyszDvwRiG2utO0EvQ+z5ou0+tRt8xG1v+Lftp60yV
	Q==
X-Received: by 2002:a05:6a21:9018:b0:3e0:e542:4ca6 with SMTP id adf61e73a8af0-3e1d0c3d35dmr6352907637.19.1792096269809;
        Thu, 15 Oct 2026 13:31:09 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:48ff:8de9:17ca:1542])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549eea48sm78394a12.19.2026.10.15.13.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:31:08 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:31:05 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [RFC v4 07/24] target/arm/kvm: Create scratch Realm VM when
 requested
Message-ID: <atE4CS3P4n5o3n3w@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-8-mathieu.poirier@linaro.org>
 <d04fe4a6-4418-48b9-b2ed-cce6278e0081@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d04fe4a6-4418-48b9-b2ed-cce6278e0081@redhat.com>

On Fri, Oct 02, 2026 at 11:05:09AM +1000, Gavin Shan wrote:
> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > When a Realm is requested, create a scratch Realm VM by setting bit 8
> > of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
> > for the guest PA size.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   target/arm/kvm.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index b4c6da1fb9f3..d86e66e056b9 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -108,7 +108,9 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
> >                                         struct kvm_vcpu_init *init)
> >   {
> >       int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
> > +    MachineState *ms = MACHINE(qdev_get_machine());
> >       int max_vm_pa_size;
> > +    int vm_type;
> > 
> 
> @vm_type can be initialized when it's declared.
> 
>        MachineState *ms = MACHINE(qdev_get_machine());
>        int vm_type = ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL;
>        int max_vm_pa_size;
> 
> >       kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
> >       if (kvmfd < 0) {
> > @@ -118,8 +120,10 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
> >       if (max_vm_pa_size < 0) {
> >           max_vm_pa_size = 0;
> >       }
> > +
> > +    vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
> 
> () aren't needed.
>

All fixed.
 
> >       do {
> > -        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
> > +        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
> >       } while (vmfd == -1 && errno == EINTR);
> >       if (vmfd < 0) {
> >           goto err;
> 
> Thanks,
> Gavin
> 
