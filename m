Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5603D75C2
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447095; cv=none; b=PuX4wpE+3OWcZH9ZFXxZ7dGJ1ptGzs96vxBfU63OGDzNBXKVjNYS7Dy9kdYYROd2tk1QNFyKWqhaseBCli3qblLv6muDda8GBxeQF05SAMjc3Svd/t/GfoPChpt01pozy5iHRiU8nhD7aWSLFuYOGHNLphWkyOawwQPEHSOXWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447095; c=relaxed/simple;
	bh=O87oU9Fb3GfKmf6vbnol7Em2lHY9Uv+VCYWvp85rtP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8KSyJ/S9CDAQevYNsDev3ZUbiHbNdYVLvapcAf+LU56gOrAGVlXD4psFVMUBcnt7UY/nbF4D7qBFYT5AEXFG5Yre29pUPQdratC3WNyitp47kWMOUDbRf/1qg3bwC0QCA+HxUpXsYcNM/bR/IXNV90MMJ+Yn4oqm7UNv22P19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C14c3Kj0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C14c3Kj0"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so2026675e9.2
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785447089; x=1786051889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O4aYxqAdUOYM4AMAjFlgTBaleZEy4IWPgN5zXutE3dw=;
        b=C14c3Kj09egPVdPZvtXhDikbtSDlxk+ldqoZpy6htouIb2/kGzu0F+LvLCjE164aFz
         jvJroCGdxn5E8Bn4Mtm9SqAEIFa+GoTKvcXNTOf1SeCu6No5PezQ2sdMlo2Fxu9myl8g
         dYBDcQBMCT8l3OqLKpMzC2VPm+ff/Sfs2+AWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785447089; x=1786051889;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O4aYxqAdUOYM4AMAjFlgTBaleZEy4IWPgN5zXutE3dw=;
        b=P6RxJcJxROMpvDPDKfpW7T+cxAgZG6De9j2VZmbn0TUryuxquf7UtLPMUC+MXrPAaQ
         a+edYokhy3IrsOi9ax5H7Z72/v9eZcCgK3apuFE8PbmdChiYirlK+XWBPlOx9efHKd67
         StXBFXn/oaLhC1fn/eAXTjrkyYlGdFyptFwXom2e8A5qGMW9x2h9D1Y6Rxf2rGQQ25M/
         I6xpgj4PWrta1vTKkWx0Sr2f4ctqqy0NzejE3uCUCZE/Nw/yhOJFu5D52XrhIDAI3jAC
         zUinkstDn7r1w31xzrCfONyNATR/O/pyvMw3jUUG//o0hIMwIcTV/J4oGlQg9f9w9cX1
         Xljg==
X-Gm-Message-State: AOJu0YxnGgBHoRXrmBOh03MJxKssFkhVylwqVvtcCfvgs7BZcFLsW00c
	GK9H7fVcCj79SIuoviNde0BPc+ruZT4mrMRFMAQCH9Ih1tmNFQKZiMMQpzS6tBbUYJNpNYPlQq/
	Yi43NWlv3
X-Gm-Gg: AR+sD11ucnXc0rc28g1POXsFM0AVJ9z09BAsONLS9y9YW4rbiTp0YzrZqq9HJj20X84
	mdEyrecn4z/PiyjO0GSorxpxHnhg+StXAHgdVBtlyujyXXTQeTSrFr/pi8PcqIQEcu6x9jwQvZD
	Uf9Jhg7WN2vn/iXZITJaLSged/TqqatcJWLxU1iTzz4cC2iYkE5ZNQwmVvfNvmCb3Ei26RL0cez
	WcrNMhAXcIZwswlFDAoftjtyxoMHkH7jFmZiwVUZ07tFwRp7WfG0hvTTmYsHV8k1eV1oMUzAlSg
	daM7WVeWTf4aO+Rd/PE6OvEbELmWizxv8mmWFLpNc7BzIGYtqa79qMsLmWLzqSxVyHBc7jJSyuX
	bYmo0Ypmbsw6PJ9juuxNpgT5FdfRz9PfVJVoNOifPWCSluGM8EEfGIjyKOupj6ZaiWyqty7pVdY
	jemqeABAIXy732lvxZP8tLlfK1inTY9aPij1JtcRevLWjaOj2SBVkCvsctHa2m//o=
X-Received: by 2002:a05:600c:4747:b0:495:4811:d71c with SMTP id 5b1f17b1804b1-49800e7592fmr59495625e9.13.1785447089066;
        Thu, 30 Jul 2026 14:31:29 -0700 (PDT)
Received: from google.com ([2a02:a31b:20c3:6680:c10c:309:fdd2:f109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e439asm8757792f8f.11.2026.07.30.14.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:31:28 -0700 (PDT)
Date: Thu, 30 Jul 2026 23:31:25 +0200
From: Dmytro Maluka <dmaluka@chromium.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH 1/3] KVM: selftests: Fix treating KVM_CAP_MAX_VCPU_ID as
 inclusive
Message-ID: <amvCrTMCjgkjtGVx@google.com>
References: <20260730182425.1223530-1-dmaluka@chromium.org>
 <20260730182425.1223530-2-dmaluka@chromium.org>
 <20260730185243.CD3201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730185243.CD3201F000E9@smtp.kernel.org>

On Thu, Jul 30, 2026 at 06:52:43PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The selftest changes assert that setting `bsp_vcpu_id` equal to `max_vcpu_ids` (the exclusive upper bound for vcpu IDs) will be rejected with `-EINVAL`, but the KVM kernel code was not fixed to enforce this and still returns success, causing the tests to fail.
> --
> 
> --- Patch [1]: [PATCH 1/3] KVM: selftests: Fix treating KVM_CAP_MAX_VCPU_ID as inclusive ---
> commit 985e68429c6e20e59d983752bd84f5dc599b83f0
> Author: Dmytro Maluka <dmaluka@chromium.org>
> 
> KVM: selftests: Fix treating KVM_CAP_MAX_VCPU_ID as inclusive
> 
> This commit updates KVM selftests to treat KVM_CAP_MAX_VCPU_ID as
> exclusive rather than inclusive. It modifies the tests to assert that
> setting a boot CPU ID or vCPU ID equal to or greater than the maximum
> capacity will fail.
> 
> > diff --git a/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c b/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
> > index 7e2bfb3c3f3ba..43f16c052de4a 100644
> > --- a/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
> > +++ b/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
> > @@ -30,22 +30,25 @@ int main(int argc, char *argv[])
> >  	if (kvm_has_cap(KVM_CAP_SET_BOOT_CPU_ID)) {
> >  		vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *)MAX_VCPU_ID);
> >  
> > -		/* Try setting KVM_CAP_MAX_VCPU_ID below BOOT_CPU_ID */
> > -		ret = __vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID - 1);
> > +		/* Try setting KVM_CAP_MAX_VCPU_ID below or equal to BOOT_CPU_ID */
> > +		ret = __vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID);
> >  		TEST_ASSERT(ret < 0,
> > -			    "Setting KVM_CAP_MAX_VCPU_ID below BOOT_CPU_ID should fail");
> > +			    "Setting KVM_CAP_MAX_VCPU_ID <= BOOT_CPU_ID should fail");
> 
> [Severity: Medium]
> Will this assertion now fail because the kernel code hasn't been updated to
> enforce this behavior?
> 
> Looking at how KVM_CAP_MAX_VCPU_ID is handled in the kernel, it checks:
> 
>     if (kvm->arch.bsp_vcpu_id > cap->args[0]) {
>         r = -EINVAL;
>         break;
>     }
> 
> If both kvm->arch.bsp_vcpu_id and cap->args[0] are set to MAX_VCPU_ID, the
> greater-than condition evaluates to false. Will the ioctl return success
> instead of -EINVAL, causing this test to crash?
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/kvm/x86/set_boot_cpu_id.c b/tools/testing/selftests/kvm/x86/set_boot_cpu_id.c
> > index 8e3898646c69d..1c4ebdf8e82c5 100644
> > --- a/tools/testing/selftests/kvm/x86/set_boot_cpu_id.c
> > +++ b/tools/testing/selftests/kvm/x86/set_boot_cpu_id.c
> > @@ -39,8 +39,8 @@ static void test_set_invalid_bsp(struct kvm_vm *vm)
> >  	int r;
> >  
> >  	if (max_vcpu_id) {
> > -		r = __vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *)(max_vcpu_id + 1));
> > -		TEST_ASSERT(r == -1 && errno == EINVAL, "BSP with ID > MAX should fail");
> > +		r = __vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *)max_vcpu_id);
> > +		TEST_ASSERT(r == -1 && errno == EINVAL, "BSP with ID >= MAX should fail");
> 
> [Severity: Medium]
> Does this change also cause the test to fail against the current kernel?
> 
> Looking at the KVM_SET_BOOT_CPU_ID handling in arch/x86/kvm/x86.c:kvm_vm_ioctl():
> 
>     else if (arg > KVM_MAX_VCPU_IDS ||
>              (kvm->arch.max_vcpu_ids && arg > kvm->arch.max_vcpu_ids))
>         r = -EINVAL;
> 
> Since the kernel checks if arg is greater than max_vcpu_ids instead of
> greater than or equal to, will setting arg to max_vcpu_id return success
> here and trigger the TEST_ASSERT failure?

Yeah, I should split this selftest patch into two: the changes which
prevent the KVM fix from breaking the test (and thus should go before
the KVM fix) and the changes which break the test unless the KVM fix is
applied (and thus should go after).
