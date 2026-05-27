Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B33F9267
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881784; cv=none; b=EDqnL8yUYG1OdsRmKl7ZdSrt49+d7PFofMGLrnQv0gzL0bZQ9ZVf4SMONvdseyPxHcb7hk0h3HC8kPh2UHHSVRApzpZjBREcWS1jsHYqJrUWpBLkA7ST6q1Bl/QOpp3gdyR1LHBMevJrC5YJnO43vKxsaabzPAPnY8QTJ2Jz4HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881784; c=relaxed/simple;
	bh=Ox1/u8ETRmBP8fbh96OnHd4k0Ijf3t81yA3eK1b17q0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=XV8oMb5CAsZROpLCpKn47vmrpy19L79fMJFjbHOeeViJEAbivEAQVAIG/mTEgfXTwojmEL+6gEpY7U8tlKFQ9e3oxluLQAB0OTVBzSXiLT0GK/+XWPS6E3CyugEq2EBu7piA+xJqCR6/dgCrFWMuHJIZbD1WUGxrizpZzWO+mc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZvPsSEp; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZvPsSEp"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-366375c4076so5039987a91.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 04:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779881778; x=1780486578; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OBwJckIjnNMjSafxeOFpVmfknD9YcolFfX87IwoV4Hs=;
        b=RZvPsSEpr37r383KtT1y3E+OJnvnOnEmqfzv3VKFeVoFoTGtwCZmrGsolOtJYfr0x7
         q2DinG3p53NfY8f3eYsbX2Qi3Hg3lg6rmYCZh0LGv3oqsQq/put7oFxzvOiOmQpgFviR
         uQjIq4Fw5XN50tqQAt6yVBIEEBUsxKaGGtNjxeeOdG2Rf8OfkOfOgjTGedfdFEeogFmu
         2SilMPP0bufr7NoJlbSDblExDVYpjRhtdlL1e64El6o6vGfmd/hTtnMG3X6+JqbDuVUT
         nJfDLIra7NiZffKI0hpgZdcDZgVBGGOyjkL0i+Fxev6U2a4hHY22td9WFXsRhGHvPqms
         0lIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779881778; x=1780486578;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBwJckIjnNMjSafxeOFpVmfknD9YcolFfX87IwoV4Hs=;
        b=SP0VgWGww1i+gB5KalWRjkCVnriTAbOLriKfBJhHsqzmGX+BijFy534knpkMVmsFXI
         FyfCKwbh4C83Gs9Swsyc7jW+x9uTD23roYn1MGaggSrz98yftk7L87bfDwcq/iFai+ux
         /z0KY+V/+tEoMJkvjq6I0yMH4npzT2GmsijqCvWwJodll8jLTPK7JHXTcuNSgCgqynfB
         xaHmm8vtg8TNfj11m6BVBIi40JaX8mJ0SxPrJFw5NAZDqJfbxBnVWED9wmL5w/QkBR5P
         XzSBOvfzZshSEG9hsuxz0LwojdEJajFtL6eO7yIN1hPTEZ7LQXV7Oh9XJsdqJ/tj/g8P
         Pq6Q==
X-Gm-Message-State: AOJu0YxJLB2piDKNmBDOGC/FSoqByNLLEW9f9UkCTwggaLYiM+7HCwkN
	Oy6VBuNIJu6DuNnyPNBF+OmfRoL/PEKS62qxGYtwHGalJGJJTbXMBWp5zS97zg==
X-Gm-Gg: Acq92OFeaJ87OeIzeAhFi4WWbeEjb7f+d2Lt93MtjPmAqxiyZXDQE5tvgwEY/gamWmS
	3YORJu3RUoFw9UjwiNIm1ShdIrUjGa+7BIkCteJRc3dVULmuoQOihYwe2FIbeWhEdpllmAg2e31
	x52k0BTCuiDkFMucaRg+t6rSFXynBOyvX957TyAWB6lu6CUOhwPmWNiysVzvAeNxFFiKmn779q0
	3go45XkJY7PhX25nabFHobHKC4sriKkT5un0P46Aei3j9CDVNuX4Y2BKtPJeoD4p27g+VHYojB2
	Ly+Ds7S8nU9BF1vP/sAUA2FB8my6H8EMvDc4wVzIkKA/jPvd3qugv7ZDgXPLZtC/H/OUdt44uxg
	kcWJJZgCniqk0tuvKr1VvV/HtVmZ5zHVALydjnXkgm+lrAz4g76FRyRMvQ28WIAgwYL1jw7xyXR
	du0RIlawGSbYp/E9WLD6WC7Q==
X-Received: by 2002:a17:90b:38cc:b0:361:45df:102 with SMTP id 98e67ed59e1d1-36a6765b589mr21645367a91.17.1779881778307;
        Wed, 27 May 2026 04:36:18 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b24d9c5edsm798906a91.3.2026.05.27.04.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 04:36:17 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [RFC v2 5/5] KVM: selftests: Print the vcpu_id when KVM_CREATE_VCPU ioctl fails
In-Reply-To: <20260523124853.102E61F000E9@smtp.kernel.org>
Date: Wed, 27 May 2026 17:00:56 +0530
Message-ID: <qzmx6qdr.ritesh.list@gmail.com>
References: <12184d5eda089814659d5a861b3ebc30d42733a3.1779524962.git.ritesh.list@gmail.com> <20260523124853.102E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The added `pr_info()` call clobbers the global `errno` variable before it can be read by the `TEST_ASSERT_VM_VCPU_IOCTL()` macro.
> --
>
> commit 9022e7c111e4121ff5a4ed4a90dcbfd2df0a62cd
> Author: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
> KVM: selftests: Print the vcpu_id when KVM_CREATE_VCPU ioctl fails
>
> This commit adds a debug print statement to display the vcpu_id and errno
> when the KVM_CREATE_VCPU ioctl fails.
>
>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>> index 0dc67c1502cfb..6a0ee68036236 100644
>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -1354,6 +1354,9 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
>>  	vcpu->vm = vm;
>>  	vcpu->id = vcpu_id;
>>  	vcpu->fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcpu_id);
>> +	if (vcpu->fd < 0)
>> +		pr_info("Failed KVM_CREATE_VCPU for vcpu_id %u with errno %d\n",
>> +			vcpu_id, errno);
>>  	TEST_ASSERT_VM_VCPU_IOCTL(vcpu->fd >= 0, KVM_CREATE_VCPU, vcpu->fd, vm);
>
> [Severity: Medium]
> Does this pr_info() call clobber errno before it can be evaluated by
> TEST_ASSERT_VM_VCPU_IOCTL()?
>
> Since pr_info() uses standard C library print functions, it can modify errno
> internally even on success. TEST_ASSERT_VM_VCPU_IOCTL() captures errno
> to detect specific failure modes and to format the assertion error message.
>
> Could this cause the test framework to print an incorrect error code or
> bypass checks like dead VM detection when KVM_CREATE_VCPU fails?
>

yup, I will fix this in v3.. Something like this -

+       if (vcpu->fd < 0) {
+               int saved_errno = errno;
+               pr_info("Failed KVM_CREATE_VCPU for vcpu_id %u with errno %d\n",
+                       vcpu_id, saved_errno);
+               errno = saved_errno;
+       }

Also I noticed that all other KVM selftests have moved from

uint64_t -> u64
uint32_t -> u32
uint8_t -> u8
int64_t -> s64
...

So, I will add separate patches on top of the current patch similar to
how it was done earlier to convert powerpc kvm selftests as well - to
keep the review simpler w/o mixing too many changes in v3.

-ritesh

