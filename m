Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0816930E0E5
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785535458; cv=none; b=piq1A2JCoO7jJtazp6qkHY/pX5EVbumLYO2uF2mAQ8i9NwfHuFHcOv7M6SvL3PNqKOR0T2UtKmedqi1JXp/HNv5+ZXIwZYnCS8jmiaygKfx7jgdD/Y08b3Pdbpc+t02se+JfqZh7vNyIKv80z4A/eTPAYZnbvNr7/EmD29bmv4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785535458; c=relaxed/simple;
	bh=MHqkxONd47xYtXkQvMIn+bZeV1Kl1MS+VS9PxsAVyfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=osnp0ZsZLNvgMWRaiPhTjLMlv491cofjKPSu8ELevoUwqZrxQsD9Im3OJciYxCFJ3Om8oPOpopRXWPiRRQPC0ftAGlPMc849iQ9JW6vQTYxZI8FOOP24HSLVk19gPFXa8mvR59E17g62wfK7ZO3fjBT203tp53a5Cwvrdci94J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pu0sdSlB; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pu0sdSlB"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so1618118a91.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 15:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785535456; x=1786140256; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kjm1X49/TS50eJc3UJI0XiqdzXOvgZST2gXdTEOC2CE=;
        b=pu0sdSlBY7rLbYlglYp3/Hvabr353s4dXLqY3CxkrsvEO0ZVPogYT0IFJnN+X4HLby
         CZ6P0QciehGB4isurkcDf4cEvD9i7AYonvW9LmQLPQH9CQJdLWpy7ksw3pz9oCftlUXC
         Is+WhHIHyL2ev/3zD6GXQ0ifuaZolWqI4UD9yeRKMda4AKYXMM7CUAZWxqbuve663xAK
         xNBQ3lMJEmHc3XyAm6ybGbW5pwXI+D1yFBPJwc2dy/Ni0gJNQSBSZ9feWOjW8fU8Gj87
         izMPPFGIYgF4MvHBEWTOGJIQVGtbb1r7f1RvA3jz9LjtzzK0idTlVpMqSo2Zw3QVzpVK
         paNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785535456; x=1786140256;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kjm1X49/TS50eJc3UJI0XiqdzXOvgZST2gXdTEOC2CE=;
        b=iu3NEd7xagN0g7RFXuZYfWhfhBfM9+tr0QGpZ83U6diD4jnZgTRed7Lr4atI7AYa9v
         s6ncVGHHRhYmnSMcsZ7b+yg27DgAMB/C6C/n42XzQDY29v6oNmYlA3EvviynpD6hRTOZ
         vsko1b+gecZ4IDYddtd4Cq46b2Y+Icow5Lt0wAiXE5R1bETo5b3bTw57p2R7kdQr8U9U
         RGx+YpOD+QdbwILPcQ6IxoKn9bDU3bSK44WIhZhDLZipV8OgvprTa5KSV7OibL7BJfxP
         /KcHiEgboiO/Fak5c53VzdT3oVjhoTcSYKof/RJuRvCbjQUcm9GVqBCsl9OBe80gsnEM
         6TTw==
X-Forwarded-Encrypted: i=1; AHgh+RrgI5c+wWVPmZwn6Cuu4oCEpHk9hQFQ4zWnvuSGjhdppC4zIbwNCASat2xYmBzFMbbwAc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0wttgvtFmxp3yPf8JWfvyL1NjUMU86ItwrTwNwP6T1HmvNtjO
	o/ALcLOghObx6PR6VqRjUnBc8lpdSCfWkWB7ZIKtqGYKsefGWKdzaSilOYLnG/oqiqlL+h8Ph+h
	W2lqVTQ==
X-Received: from pjbie11.prod.google.com ([2002:a17:90b:400b:b0:38e:b8e0:d97d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57e6:b0:38f:23d6:b4ad
 with SMTP id 98e67ed59e1d1-38fbc3f7e43mr1187379a91.8.1785535456041; Fri, 31
 Jul 2026 15:04:16 -0700 (PDT)
Date: Fri, 31 Jul 2026 15:04:15 -0700
In-Reply-To: <20260710050442.826777-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709174955.628913-1-hemanth.selam@gmail.com> <20260710050442.826777-1-hemanth.selam@gmail.com>
Message-ID: <am0b36OWeFSy2faX@google.com>
Subject: Re: [PATCH v3] KVM: selftests: Add a test for KVM_CREATE_VM VM type enforcement
From: Sean Christopherson <seanjc@google.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

A handful of nits, but no need for another version, I'll fixup when applying.

Thanks!

On Fri, Jul 10, 2026, Hemanth Selam wrote:
> diff --git a/tools/testing/selftests/kvm/vm_types_test.c b/tools/testing/selftests/kvm/vm_types_test.c
> new file mode 100644
> index 000000000000..e8ef3b018f6c
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/vm_types_test.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Verify that KVM_CREATE_VM accepts exactly the VM types enumerated by
> + * KVM_CAP_VM_TYPES, and rejects every other type with -EINVAL.
> + */
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <unistd.h>
> +
> +#include <linux/kvm.h>
> +
> +#include "kvm_util.h"
> +#include "test_util.h"
> +
> +int main(void)
> +{
> +	unsigned int supported_types;
> +	unsigned long type;
> +	int kvm_fd, fd;

Probably worth declaring "fd" inside the for-loop.   Definitely a coin toss on
which is "better".

> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_VM_TYPES));
> +
> +	kvm_fd = open_kvm_dev_path_or_exit();
> +	supported_types = kvm_check_cap(KVM_CAP_VM_TYPES);
> +	pr_info("KVM_CAP_VM_TYPES: 0x%x\n", supported_types);

Rather than "KVM_CAP_VM_TYPES" print a more human friendly message, e.g.
"Supported VM Types: ", otherwise it's not entirely obvious that the message is
printing the result of KVM_CAP_VM_TYPES version the raw macro number.

> +
> +	/*
> +	 * KVM_CAP_VM_TYPES is a u32 bitmap, so only types 0..31 can ever be
> +	 * advertised.  Walk past that range as well to confirm that any
> +	 * out-of-range type is rejected rather than silently accepted.

Rather than lean on KVM internals, I think it makes sense to express this limitation
in terms of KVM_CHECK_EXTENSION's return values.  Which is still kinda sorta an
internal detail, but it's at least more visible to userspace.

Specifically, track supported_types as an "unsigned long", and then have the
comment talk about KVM's deliberately retristed return value, not how KVM tracks
its supported types internally.  As a bonus, the loop can iterate on the bits per
supported_types, not a hardcoded "64".

	/*
	 * For compatibility with 32-bit kernels, KVM_CHECK_EXTENSION restricts
	 * its return to 32-bit values, i.e. only types 0..31 can be advertised.
	 * Walk past that range as well to confirm that any out-of-range type is
	 * rejected rather than silently accepted (or truncated).
	 */
	for (type = 0; type < BITS_PER_TYPE(supported_types); type++) {

> +	 */
> +	for (type = 0; type < 64; type++) {
> +		bool supported = type < 32 && (supported_types & (1U << type));

And then if supported_types is an "unsigned long", the "type < 32" goes away.
A bonus to _that_ is that the test will Just Work if future KVM does enumerate
support for types > 31.

The bitwise-AND can also use BIT().

> +
> +		fd = __kvm_ioctl(kvm_fd, KVM_CREATE_VM, (void *)type);
> +
> +		if (supported) {
> +			TEST_ASSERT(fd >= 0,
> +				    "KVM_CREATE_VM(%lu) should succeed, KVM_CAP_VM_TYPES=0x%x",
> +				    type, supported_types);
> +			close(fd);

kvm_close()

> +		} else {
> +			TEST_ASSERT(fd < 0 && errno == EINVAL,
> +				    "KVM_CREATE_VM(%lu) should fail with EINVAL, KVM_CAP_VM_TYPES=0x%x",
> +				    type, supported_types);
> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
> index 8db88c355f16..d4227dc922ab 100644
> --- a/tools/testing/selftests/kvm/x86/sev_init2_tests.c
> +++ b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
> @@ -77,10 +77,6 @@ void test_vm_types(void)
>  {
>  	test_init2(KVM_X86_SEV_VM, &(struct kvm_sev_init){});
>  
> -	/*
> -	 * TODO: check that unsupported types cannot be created.  Probably
> -	 * a separate selftest.
> -	 */
>  	if (have_sev_es)
>  		test_init2(KVM_X86_SEV_ES_VM, &(struct kvm_sev_init){});
>  
> -- 
> 2.43.7
> 
