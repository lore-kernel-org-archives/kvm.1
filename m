Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9073F6C55
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881462; cv=none; b=Z7QLao3v9EAxGTyz+jutgvKu9M/65YCMOPcT2m1iLXjBZb3BhUiyDS0lgvQk5fJriBMB5j/x1JyEJmg9NNgXjdA1L+cZWBbViONdgS/6dNa53tmTXNtfDD9/elcXoEcxX8En0cQy4IB6W4r8PWlur1tVIWERlfLsSC7gRHBioCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881462; c=relaxed/simple;
	bh=r3p0gSNrpDh+6wnNLHisMohXJjlIuMXp1tbrE5pgqz0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=KX/AxOVonV1ZtpNPCWpZHFrumyeGA9PoxXwP1hZIH9ObMISa1fUduSKEVYz+VBG66/HcLuILiORQyjxBeYfFMzc6P+hHsNu3jq4OyR/3nXYjTMjLl9hOIQfgOuWAYATL8acoEFpUY9/xGkKEGjop979dxDTtOGXNJaK9JXcp5Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl1CrjKV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl1CrjKV"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so5155288b3a.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 04:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779881449; x=1780486249; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QZ5qiaV6o/rT83Qlu2laa+IgIwU5V8Xgt69ba/3cprk=;
        b=Nl1CrjKVdaee2yiPhQvN4jFGsI0q9mkcKdD24BEI2QdgFDPFE2VuWJvuX4rCsj1EAV
         P3K8yKeJSBYh4LR5UoYvUy0K3rxJ74CjNCtXyB+G8Pdq8lN2+qMXelXQh0Z7ZH9aIOtk
         yn6Dp4i18uHhAwo5IseYXcl8+kF9VXbI72vkp9AUIerOtV21dbDJInVxPGvmj6FU6fTP
         sjJ8EWDehYrZpvNphmucnmfxERabSjZocmRCiTg4f5QpA3tPG4WXJX9htjoMDXVYWvDz
         q3BXX9BWVUKWxRWXCbA6AgvzInCbPgmuecT4/XjYZkKK1WIBSOymZKtsfytfQXZ239BF
         3+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779881449; x=1780486249;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ5qiaV6o/rT83Qlu2laa+IgIwU5V8Xgt69ba/3cprk=;
        b=BTP4fmNEPPQyxUZV2I6bXzP0k088E4A5KVXD6LNmtvLpHXwiHv/dls6rzkRJ3/+9tV
         NnSMc3yHEkUqY+9hdCnCruyMaF3adC6OqOQqE/mAcXz1tifK+2mzcvE3eG1PG1GXay6g
         l1lawi2GNKRwL7Swv06VuBngZl+j7Pn/BbSMk7V113IDyb34FAg8Z7Ijeu24+Cod7QWk
         DdyESRbbjIN5R1E6xwFUonlDnWk56DJU5DzqdhN9DXs3KwL2j0VNdYCFCLqCS3atv9DF
         G+jrTX0uc1xqfZE6kQo5W8SYl7nuMTuQbwKRNfV+nr/8sOBQPqkmjHGCzEzINIbkUPmu
         wk+A==
X-Gm-Message-State: AOJu0YxNwyL+zsjg6IcwJ6LTU4nhTDOjs5RBy+JgBfiVfwVOfnqnnLmc
	icyMElTNT5Fpz3HksbciMCmROur4KUI1EzVB70l8ii53axyn80B9WcZbJcSKjA==
X-Gm-Gg: Acq92OH+jBpo3ufaY0r1jaAJD9TASq36x6+FNCF5eC522vz4EqaBi8Os5iiDF/+pyTJ
	YQv8SZUleceKLzCc6NFCAMVMJl+R8fhc8iYWdwVR6lw4FxqCUop1jyYg6XDv9OzHJNfouKUb/0h
	bCUBLiPGcmVdVI1Ur1pZHhEUn1gs1onEPkVbLeaQ+7tJMjQy7FAjchLkht5Qf/L5wJuK/WQMYRx
	Gm7dQNUjqERfCAHdlhfcVo6J2qk7Nv3BY3GBigBEF1Z595ON3s/TkNOiXBAQEJ5pU3nFm6P+FBq
	I1Ncy2qY8cmXhkfFxSCK5OKRVUxExutWDNvDdiQy98Vvt6MQ0pRefICy1ZagxeUwqMwBN84yu2s
	Z1wslKQ5Eyhh6BXN4ns1fNJVel3sfoW/+bKPKpJlz7SV8MtiRaAunMiGjWC+nuAqeOW6rQEWrZ1
	J2r9icH+Yan5do3D4hDe3ukw==
X-Received: by 2002:a05:6a00:1bc4:b0:829:7a62:6a with SMTP id d2e1a72fcca58-841611e3202mr16669715b3a.22.1779881449287;
        Wed, 27 May 2026 04:30:49 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6d60d07sm3209200b3a.0.2026.05.27.04.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 04:30:48 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [RFC v2 3/5] KVM: PPC: selftests: add support for powerpc
In-Reply-To: <20260523123023.64A321F000E9@smtp.kernel.org>
Date: Wed, 27 May 2026 16:46:04 +0530
Message-ID: <se7d6r2j.ritesh.list@gmail.com>
References: <6e0c74f1273a4baf652d84820ae83696e77263d9.1779524962.git.ritesh.list@gmail.com> <20260523123023.64A321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

sashiko-bot@kernel.org writes:

>> diff --git a/tools/testing/selftests/kvm/lib/powerpc/handlers.S b/tools/testing/selftests/kvm/lib/powerpc/handlers.S
>> new file mode 100644
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/lib/powerpc/handlers.S
> [ ... ]
>> +virt_handle_interrupt:
>> +	stdu	%r1,-INT_FRAME_SIZE(%r1)
>> +	mr	%r3,%r31
>> +	bl	route_interrupt
>> +	ld	%r4,(32*8)(%r31) /* NIA */
>> +	ld	%r5,(33*8)(%r31) /* MSR */
>> +	ld	%r6,(35*8)(%r31) /* LR */
>> +	ld	%r7,(36*8)(%r31) /* CTR */
>> +	ld	%r8,(37*8)(%r31) /* XER */
>> +	lwz	%r9,(38*8)(%r31) /* CR */
>> +	mtspr	SPR_SRR0,%r4
>> +	mtspr	SPR_SRR1,%r5
>> +	mtlr	%r6
>> +	mtctr	%r7
>> +	mtxer	%r8
>> +	mtcr	%r9
>> +reg=4
>> +	ld	%r0,(0*8)(%r31)
>> +	ld	%r3,(3*8)(%r31)
>> +.rept 28
>> +	ld	reg,(reg*8)(%r31)
>> +	reg=reg+1
>> +.endr
>
> [Severity: Medium]
> Are r1 (stack pointer) and r2 (TOC pointer) missing from the restore sequence?
>
> Since they aren't restored here, tests cannot modify the stack pointer during
> exception handling.
>

The guest exception handling carefully create and destroy the stack
frame during exception handling for running C code.
Also LIBKVM is directly linked in as object files directly into each test
binary, so the call to rout_interrupt() is the same TOC call.

So it's not missing, but we really don't need save/restore of r1 & r2 here.

>
> [Severity: Medium]
> Is it possible for tests to map memory without write or execute permissions
> (e.g., read-only or non-executable pages)?
>
> If so, this assertion will falsely trigger and abort the test during virtual
> to physical address translation. Should this check only verify PTE_VALID and
> PTE_LEAF to support testing diverse page permissions?
>

Yup, that is something which can be relaxed I guess. Will do that in v3.

-ritesh
