Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999A442FB3
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512689; cv=none; b=Fi7mrAwgz3m+WRq2KMyaNc7Pz9Hx7CsV/NumXwsOs9KD346PyB1BxLC7l0vgcFlkBvghs9iZTkYzxCPupTKsm1K2qB3kRnUBBx1es4zXN2i7AOv19xxSVpP+5VBdztJviIvpOvNfeE9VW3P2Qj916TkkkIhouyUlMDmJoKkKubk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512689; c=relaxed/simple;
	bh=VcL8BXxn3Qq0fLyIIYCp9w7e2Bu7vNh9LjvUbXNwyfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsfQ3X8oETdvk9MnPCQVnP8dOOTldm4LYAiGWrI95FTFR7hTjP579s0IzE5qkDgJvwhHr7wQazABmhsdEsPtG93ja2FHgqUXrMlT7CoCJcxxaBaHe4dT06ke9EVpZgJ+q/0Q6HTSuIyeGf5B29yfjx5TuBxkt4gyhWIckEBC8qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N1chq+l1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N1chq+l1"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f71156e1aso636654f8f.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785512686; x=1786117486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9vJ13y8Hgv8RV6M9Mxzw3aYrgIriTaGFeY14syFHihY=;
        b=N1chq+l1PhLcq3ebeUpVFJoPVeVnM6DGo2oIkZuXOE9mHN5TVsvOlmeu1ooMM0H/2W
         Ls7f/1IdM8ldNPIX1CQKttP07OvWTGNoxYiEOHKCZUVSWcCXuicEoAr4HNRCYJcihU51
         7t//C19zUYlYOatOwbDXwL0SRTFXYjJtf0MGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512686; x=1786117486;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9vJ13y8Hgv8RV6M9Mxzw3aYrgIriTaGFeY14syFHihY=;
        b=bxgHiIZgx7e7x2/n1Qg4far4VMynJvZHoSOVFSvp6W964o1DA+5jEaZVwu3cJwPrU7
         mxJoxtS05j5wF7rwYrk14VmQVJg0JNpUwiGi0/8b/REg/AXOFp7+LbS/uqHu//S2rQOU
         GiJi9JISkpXCWIC0CYhkp4nDZ6LdPRObFMSnFxVE9cT+DlnPsx4eeW/8YE1r1TLt8rBq
         j0Vg+nP/XNZdK9xey5d4f4xEDzgPLmeyopweZP6NizF+1gk68hFpJfPPOXaZZyO+Z0QF
         DjrrTCJCtkxYYHf9+0HVbVN7Ps9g3W5guTO4x/1zA40+7merQkFHN2dU37j0L3DT5GML
         OIKQ==
X-Gm-Message-State: AOJu0Ywrl1pF5zTuPw48JPWNnzb4BQEaXtFoEjPnZbbbrDy5EPmpZ3ko
	LRtL/BNspRiGyg+5OOL72VsKFlX2K5zR4Lmbt8I+BW9NCH4RnlwIbmCWqRvQIb0jrGBEZrWd9cf
	CWyeClg==
X-Gm-Gg: AR+sD11X6uqP5Bb1tJ2C2iWb2Od5uqIeC+eo5ogA5uY8/9Joj0BlgeZosuoyQGeGKGQ
	Kna+0u58UXgddY6fw4pYhj/wCIHnUM43s/VcDzVJ5w7kcTRQDMs4sj1dDBT0KOUX3AMfOgO+Bvu
	R2e9TAiAds5VTdM76imlR4Yy0h8OfFpXusmJPWjfzbYKv9d8FcGwIJZlmPEh3gpWCdrbZgqPonP
	E3a/dQtsolUoo6uI7VBvK8fE5yXJIKiikBHT1PxIg03qQPbYe29ps7YIaAvz+NFABl3VrC4/6us
	UFAZPRMBjL4+RTrB7dPCHKG31gIq21bXEIdfuAfL4JX9uWG03iojj4ja1Stajq8Owv39mOsjEDw
	3Yi3NvaMrA6EKJCKswxwKn8AjSCMOThV7/xHmMZfL7RDlEGQN0fLh52c5Hm+XbIP6W4Y1zjZXyh
	gZsFaR2r4+FNOqkaHBbr/tQoDu2HkgxAd4mU/9rCAWirpkMJnpWMfpYNs/CeYE0VmotIXqv4pSu
	lnxielvPz5UJObWE/mdccxf3gMDDdzB/g==
X-Received: by 2002:a05:6000:1844:b0:47d:fc33:e6bc with SMTP id ffacd0b85a97d-47fd7307ae6mr238895f8f.47.1785512685696;
        Fri, 31 Jul 2026 08:44:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:285b:8:4d52:883b:57c3:cdfc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4562a38sm5859056f8f.21.2026.07.31.08.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:44:44 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:44:37 +0200
From: Dmytro Maluka <dmaluka@chromium.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] KVM: selftests: Fix treating KVM_CAP_MAX_VCPU_ID
 as inclusive
Message-ID: <amzC5dDVAspfK16u@google.com>
References: <20260731150846.1728164-1-dmaluka@chromium.org>
 <20260731150846.1728164-2-dmaluka@chromium.org>
 <20260731152407.E3EAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731152407.E3EAD1F000E9@smtp.kernel.org>

On Fri, Jul 31, 2026 at 03:24:07PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch modifies a KVM selftest to avoid an invalid configuration but sweeps an underlying kernel bug under the rug by failing to fix the kernel and masking the issue in the test suite.
> --
> 
> --- Patch [1]: [PATCH v2 1/4] KVM: selftests: Fix treating KVM_CAP_MAX_VCPU_ID as inclusive ---
> commit 5e2afeaca4e83d31005f9aa5caf94dbbc9f20b8c
> Author: Dmytro Maluka <dmaluka@chromium.org>
> 
> KVM: selftests: Fix treating KVM_CAP_MAX_VCPU_ID as inclusive
> 
> This patch modifies the max_vcpuid_cap_test selftest to account for
> KVM_CAP_MAX_VCPU_ID being exclusive (maximum allowed vcpu_id plus one).
> It changes the test to use MAX_VCPU_ID + 1 when enabling the capability,
> avoiding the boundary condition.
> 
> > diff --git a/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c b/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
> > index 7e2bfb3c3f3ba..47ee14967873f 100644
> > --- a/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
> > +++ b/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
> [ ... ]
> > @@ -36,16 +36,19 @@ int main(int argc, char *argv[])
> >  			    "Setting KVM_CAP_MAX_VCPU_ID below BOOT_CPU_ID should fail");
> >  	}
> >  
> > -	/* Set KVM_CAP_MAX_VCPU_ID */
> > -	vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID);
> > +	/*
> > +	 * Set KVM_CAP_MAX_VCPU_ID. Note: KVM_CAP_MAX_VCPU_ID is a misnomer,
> > +	 * it actually represents maximum vcpu_id plus one.
> > +	 */
> > +	vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID + 1);
> 
> [Severity: Medium]
> Does this patch mask an underlying kernel bug rather than fixing it?
> 
> The commit message notes that setting bsp_vcpu_id equal to KVM_CAP_MAX_VCPU_ID
> is invalid. However, by changing the test to avoid this exact boundary
> condition, it seems we are leaving the kernel's off-by-one bug unfixed.
> 
> Looking at the kernel side in arch/x86/kvm/x86.c:kvm_vm_ioctl_enable_cap():
> 
>     if (kvm->arch.bsp_vcpu_id > cap->args[0]) {
> 
> This bounds check uses ">" instead of ">=", which appears to incorrectly allow
> bsp_vcpu_id to equal max_vcpu_ids. 
> 
> Should the kernel be fixed to reject this invalid configuration,

Yes, it is fixed in patch 2 in this series.

The reason for this selftest patch is not to "mask" the KVM bug but to
prevent the test from incorrectly failing once the KVM bug is fixed.

> and the
> selftest be updated with a negative test to ensure it actually fails?

That is done in patch 3 in this series.
