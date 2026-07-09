Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB0347520
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783628467; cv=none; b=RW7ZQIv29jlvanMDVOjZObz+lQz7dilFGAfB7W4EiIM68/LqY5czkoU0NMtbdM0qiIu2lkquHl4E/hEMhuWzNsWm3R+WP6TbpmASOlY/CER+Zmem0/jm5ccJgoqalmCvyWV/N1M/DiepHoCtcnlYqgS7lkiv9qizjC/61+uAXds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783628467; c=relaxed/simple;
	bh=q2ZOUSVusqbM4msiHCHWzW5ZDBfus1hiVGMu5NriqoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OJ0XcIey5iQTdGa0fM8iW7GrKTWp6QA4KNQ3Q8mXpNUZYhxkSt+uXr4C66J5dC7582ViJKBK3/rF/lsP3VUDU+67CjJlaKhy3InJhoQdGDiSJjgNmvxCgJXlrgAeelWvxJaPHzJsk8vhOMhjHxVQ7xjpPGPUa9HUtpDc5ITnUoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZR/QVdia; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZR/QVdia"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8483e038efeso119367b3a.2
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783628466; x=1784233266; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CxKcxzuNFCTiWIY9TtzP+QfZ+srbbSC9teFUzdNxgfk=;
        b=ZR/QVdiaOBlQ0i+ETgfWfoIPL3QBVl3FoOx2sBoETol7+XeRTwzd/e6seEznhNESGM
         24VT7q4r0tkJ9hNAJ1Hu3UIBMA3PAFEbkCiwZQt18O6mJtvYXNPPuwH51B6UHVPT7qJh
         e2IPIWM2Q6T+WjFZclCUZg5tFXhtLhxRBSvyompWayqZO0UuRJFdrg8mPxreIESg464a
         r1rODfxjceJAvL8qgwtmiMdvDzG3zPffF5MfnN8nQeXsy4TpssOemz71/E24Ugp0rbGT
         BXsoQ9XCTN7pd7X2k+KqxUFBNP8wTRw7Ki/cmHSJbsGzDpStk2QOH+BmHEiu3dix9K0R
         BpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783628466; x=1784233266;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CxKcxzuNFCTiWIY9TtzP+QfZ+srbbSC9teFUzdNxgfk=;
        b=q30MO3Zy97Jx/PAHxnJw0aOcYkTHf6t7SDG4HHTFPE1wvjlH/1+Ots66cLtWz1HheC
         sRelHoVRwGi0hWx2ppXrmdoHz+/Vdoj7Nn47ZgQZZcNgYPtczP6gALJLbZI8R04NOhPC
         VE3nd7z6t871q6dzVRIw1Xhx1lM15XpyDCul7vAYpZG1rjtyQJ1MC/ntfnl4DrNlvI6C
         V+7CH2xEAr3iQEPVyF9WtNa99xuSLynqkaYA8OztUGLHOAJTzzQ1CM0QjE/3xXYApDpY
         yJfZC8WQtBw1iTvuQEmjbiIOLnZLOnKOCDJgpphVnbo0RZN+OlsxJ/oHym6vbVWd0/tx
         ctdg==
X-Forwarded-Encrypted: i=1; AHgh+Roxe4gXz3E+/h38TlyK4a16//fL2oEFLJ+R4XcImG6JckLwL199CqAEE3SjAtUpnQGBbg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlfaAPckNrRFnVvv43RHujcV128MaJzUTEEIvBconzXWPVFhdS
	kNkupaUltJcEpIuqH7aByS1CCsOm5JkdFKeSicx6xJR/Lp7NLh+BicBuiCIPg2aI96nMTt8ukaa
	Ckk54PA==
X-Received: from pfbmc20.prod.google.com ([2002:a05:6a00:7694:b0:846:3c78:e2e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:aa09:b0:845:62ce:d5ae
 with SMTP id d2e1a72fcca58-84843021d3amr8051184b3a.18.1783628465756; Thu, 09
 Jul 2026 13:21:05 -0700 (PDT)
Date: Thu, 9 Jul 2026 13:21:05 -0700
In-Reply-To: <20260709174955.628913-2-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709164751.621326-1-hemanth.selam@gmail.com>
 <20260709174955.628913-1-hemanth.selam@gmail.com> <20260709174955.628913-2-hemanth.selam@gmail.com>
Message-ID: <alACsZ41RLIbBzfM@google.com>
Subject: Re: [PATCH v2 1/2] KVM: selftests: SEV: Verify unsupported VM types
 are rejected at creation
From: Sean Christopherson <seanjc@google.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 09, 2026, Hemanth Selam wrote:
> @@ -73,19 +74,34 @@ static void test_init2_invalid(unsigned long vm_type, struct kvm_sev_init *init,
>  	kvm_vm_free(vm);
>  }
>  
> +static void test_create_invalid_type(unsigned long vm_type, const char *msg)
> +{
> +	int fd = __kvm_ioctl(kvm_fd, KVM_CREATE_VM, (void *)vm_type);
> +	int err = errno;
> +
> +	/* Clean up before asserting; TEST_ASSERT() aborts on failure. */

Literally every test relies on the kernel to clean up fds on an early exit.  I
see no reason for this to behave differently.

Also, Sashiko was wrong.  If KVM_CREATE_VM fails with something other than EINVAL,
the assert will NOT fire, but fd will be < 0.

> +	if (fd >= 0)
> +		close(fd);
> +
> +	TEST_ASSERT(fd < 0 && err == EINVAL,
> +		    "KVM_CREATE_VM should reject unsupported type (%s), got fd=%d errno=%d",
> +		    msg, fd, err);

test_assert logs the errno, no need to spit it out here as well.

> +}
> +
>  void test_vm_types(void)
>  {
>  	test_init2(KVM_X86_SEV_VM, &(struct kvm_sev_init){});
>  
> -	/*
> -	 * TODO: check that unsupported types cannot be created.  Probably
> -	 * a separate selftest.

Heh, I agree with the comment: put this in a separate selftest.  This doesn't
have anything to do with KVM_SEV_INIT2, and in fact doesn't even have anyting to
do with SEV+ or even x86.  E.g. add a kvm_vm_types_test that attempts to create
all possible VM types, and asserts success/failure based on the output from
kvm_check_cap(KVM_CAP_VM_TYPES).
