Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792587228;
	b=knud+f9jwhF/hIVMFaESq0hZ6h5TYCE968hP5UowUdRdBhoN3w5P0x7uQCoAbIcOymII
	 pQsZ5fmg1/XvdjpZcJTUzL9yWGoPIeGvhxSnwCH7x9iqtQXNVAYNlTPSM6UX4woJFrPbN
	 NYpahwWwemdlfAHDNhqaaGE/SLsif7vtJ/L/JwZ9Go6r+w8OnOZ6NcU3FMJA+90iuciI/
	 FQgS+fFjuTUJf3zejW5hfs18bnPLBsVkEh4ZJBz2a3s/dDUcuo4Cw/sJ2wkTbps6BTVdW
	 Won2hre4n4BCtl0EayYeYhTFdpLawMK/GBu0VHc7hb2CquZcyZ+tCfh9r7+aM+Cw/EQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=vVQV8bQ7dJZGlG+AnyXvGIO0abFwqKNBWUl84ZSQwZE=;
	b=siTfc6R9FTFwrBXSb+mKymYGMMdHs7jZfLnBjY03dd/J0az4jTwDghsTktMsrzuMzVsT
	 iqmDVh0U7eAgA/ClQd8L1TMRGGlTAgsMBQWzjlRJ2fChW9KuCxh9kSs9NEvTgf9p3y6Qk
	 Q2nMAsV3tdCmEksV60VWWGUEKIGGi5nPGX8BfzgpVM8ZupCV/pyNvY80aSLH6MfpWtThB
	 Y1w4nFyh7T/6m46vjvnJFcIXKuwvGw+TVANLOeFL2GrVFffThD/JAe1fmwq3cHGb0PCez
	 aVvr1EjEqxMkYEbCaOJT/D8/5e76PVjReHfuq5AbheKOKnz51QpMPGZJixFnGwKwgSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QGeRoihD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110BD606A31A
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 12:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 110BD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QGeRoihD
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5365b48238dso6108371cf.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 05:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792587227; cv=none;
        d=google.com; s=arc-20260327;
        b=SbqcD8XgS32o2QsRvBq9dkcUpOEnWaD8DZGfzozgibZu2maHSJm+Z6LvyhatkQzxsK
         9DZci8w90dlPixyRTdnyheBrDLPkqIMVaDJghyfT8CH8ILFOhqe0gV5DH3DDvVo3EpLN
         01sZMOiwCGzdXWMdECa5rrRIQMnDzHNZ2xPrzxacPledZdvjwJ9qqTtezUm+T9Dy0zlS
         XGz9F5lBkeLiDF5i2/iE0rjh1I2ofZ1ONUzMZxscNGHQTQUDgMPA1Ffdd/wqQj8QMihF
         U1D+XELNOHUW92fUZ1xb6muXVEIJmfcNL4UWDKv/X9lasYH/zG6VVFojmJhWir0xgJ3N
         D/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=vVQV8bQ7dJZGlG+AnyXvGIO0abFwqKNBWUl84ZSQwZE=;
        fh=3L1y8mkli4P5uvLmpYXyjNjmfFuWE4BHkshm6097W74=;
        b=JeWN0h65e0by9GRWBsZ0LjOdkR8eN/yb3erZKSpnXQzbh83VDf0t1rCWjovL1CB3S4
         eJ2856HBLmkJxmLKX/dtIu8uyHLLzZSvqESRVNGeyPv1Ln//4sIcOsjwpBt8niGByawu
         pYms3rfpXrKYwSE+6GkS392CiHWkOQqDr/NmFFUoGlPcuDhISvRxlCYLPjq/xDMU36a4
         BYOaLb/H9S7ah7SO6uFApQu7o1kt9LL+jIXfNVKXtfIsc0URYUitYCDHuMkOAuPIbFJ6
         DkgKQydoZI48qtSSubrnclHmf7mlylmRQ/I3fGun1xd5XHuBUNaJovWqkWq/kbGEvEKb
         /W2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792587227; x=1793192027; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vVQV8bQ7dJZGlG+AnyXvGIO0abFwqKNBWUl84ZSQwZE=;
        b=QGeRoihD65FQdc8RvPozpgQSjV7yOWDU7rcZKasvivK+eBB4yUw8nHpwWFtGAsIy7n
         8hlP8ZksN9BUyilV0cFLqYUE9yiEc2JIqwkFJ5/fnFcUL1b87UUOrYqcnHNMyJFeU3uf
         EI5GaVjyB3nxUuKvKC9hCVvXt/J98q0dCLiYmupDCIRjPDv+4G/YtQgM4P87YebLDKuu
         rnnCReSmi9jI35inLq4N511Uwijd2OPH5XmV3lJcBOvPlmoB7aEDxslrlRgSKHqef8o7
         W8zc/Np8u04T1qU38zEOTtyeaIDz0NVYFsLdE8zTeSd+tewXXzGzVQ/q4IQhd7lv31XX
         K0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587227; x=1793192027;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vVQV8bQ7dJZGlG+AnyXvGIO0abFwqKNBWUl84ZSQwZE=;
        b=PFXxkecISbAWOFQMnURozYp6LZpwcAb44S8s923PQd4NGVncYIiHkOVo6BTdFXVJkw
         biRnwyEgVKEHUYYooIyVlqs/ag2pYgjgeH3Nhxj2BOucWIxuiwemuwEGAZmdk2CZdDx2
         UfXcZTgnJu0Q3hZjKn61bLutl5eeFOCEbAfZ/rJ+elFqbfnaScTeEDHYB20JT7jlUrQf
         xLdUJNQjuY9FKygUKAtAU65dBmAaiKVQgZmmiIXftPl7awW5XW2KUpts19044GuWsKze
         m1sPjw9K71YwqcB2ptDnDt1ehj55F/p3SHzGH9v+D1IdOZXOjHsPhGFIOTor8sXZxFNp
         R/lA==
X-Forwarded-Encrypted: i=1; AKwUvBxGw8fFacwKMbU53yi3XJjdOBfmUMuBJrfK+VIfzVUwltVfjPHd4+PQ58LITN3TqQLHsYU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLY6Kk2fAxFLUsIkidFg2wUYGK1sdUesAXLWeVMQE7rRM3MfBsZ
	jp+1enmxa9/zQUwqbrOykFL0sx2HSXweh14r4HyXM4rwXtw1Ncqr2hGtwH2f0qnbymi8KQUC+D8
	x+QoZHV9x7Oaew7TssNpKInQ/HvhPiLhd4M/B/Zc6
X-Gm-Gg: AYBFou0KVA5oD/etVNx5TFox8dkkbPyH3Yn1fR/4CN4x9423C+BBP8jqTQXmEchVBXd
	whS8SuwA2rNG51SVyIpmyrAYkjMNdyg0XXf+hk7AFqJKctVRSCMD6WxTJ9a8UW/sQmjzBljZUVa
	Miy0xtU4SyJD2RCMMRwMYPPhIWJpsOuOdqMtaeRNu06WXZoike5J0Bc86xPS7pA2T7oKCNalmKG
	lIXakn9q9Mfh97pb+LnM9aLTxJKc9ks2elOXCGiPayaYxKAKIKUdili2S4KkGHppCQ1aOwFzsS5
	jRbrV9Ijo2f17y65erZDkBX4l8GEOsocoylFQp5mO5As5rrRxabnheJUhiNh0io03iycvTi/xdB
	auNkvWEuscaO0/jU3J/8qIbUbVam6pgImtIuHHO+dD0GAptyNL+ZGJBEtmmzPrrNeUl8=
X-Received: by 2002:a05:622a:2298:b0:535:1cbe:375e with SMTP id
 d75a77b69052e-5369b86a007mr26318971cf.59.1792587226044; Wed, 21 Oct 2026
 05:53:46 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 05:53:45 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 05:53:45 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261020131447.122096-3-pbonzini@redhat.com>
References: <20261020131447.122096-1-pbonzini@redhat.com> <20261020131447.122096-3-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 05:53:45 -0700
X-Gm-Features: AclHuK_cQy3FIEKPEYLrrT0unEbP9o3cNdKisHPXC0klQRVgJdOZliD266c8PeQ
Message-ID: <CAEvNRgGceF8m5GFV0aE2ALkVEY=mvWevGmaCrgoxcLznadOF4Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: x86: leave the legacy private attribute in for
 TDX and SEV
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Fuad Tabba <tabba@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Shivank Garg <shivankg@amd.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Sean Christopherson <seanjc@google.com>, vannapurve@google.com
Content-Type: text/plain; charset="UTF-8"

Paolo Bonzini <pbonzini@redhat.com> writes:

> As of today, and presumably as of Linux 7.4's release date, there
> is hardly any VMM that supports guest_memfd attributes.  Support the
> legacy VM attribute for private memory if SEV or TDX are requested;
> default it to disabled if only the software-protected VM is requested,
> since it is only used by guest_memfd selftests.
>
> While in-place conversion is the best option, it is way too
> early to enable it by default.
>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 01a683a9042a..4f7d75ec8c40 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -80,6 +80,7 @@ config KVM_PRIVATE_MEMATTR_VM
>  	bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"
>  	depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
>  	select KVM_VM_MEMORY_ATTRIBUTES
> +	default KVM_INTEL_TDX || KVM_AMD_SEV
>  	help
>  	  Enable support for tracking PRIVATE vs. SHARED memory using per-VM
>  	  memory attributes.  Using per-VM attributes is deprecated in favor of
> @@ -87,7 +88,7 @@ config KVM_PRIVATE_MEMATTR_VM
>  	  CoCo VMs using a VMM that doesn't support guest_memfd memory
>  	  attributes.
>
> -	  If unsure, say N.
> +	  If unsure, say "Y".
>
>  config KVM_SW_PROTECTED_VM
>  	bool "Enable support for KVM software-protected VMs"
> --
> 2.52.0
