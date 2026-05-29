Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9352B36D9EE
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 04:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780028522; cv=none; b=YFlBmuSxEoVVbmPd8QA8FIQ/JFtRbIKpSLTzY+zB3GJqVw0kct0VciLtwK7kL/ITx3DDrpWtdLA/E79rPGEC5Bu/WAmYvb3fhiTltxUFeEyCPc8f7F1mFrREVUj56aov6JdTT3Sta0DssmHpGSS8odCI/poU17T2KZSH4BCZhLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780028522; c=relaxed/simple;
	bh=xzW5x9iAB6Eb/h1LY4YMe654q9jJ4E6QneGu6cWFWss=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=eui0dn/yAV+JTtsJ0AQ/13UKuS7/R6BFiLSE8eU+JDilUziKHJqresloeBPt7CHlfYrUGTsRystRrPMsbC+QYoUK/F5Vi8WYXu5DRZJadWa23ny+eSdoMOKZs2MtRNdCb22+v/Y34QclWBafMl5dGlRB4Ix4bt4+vng1MuuStRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN5BQ7Nh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN5BQ7Nh"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so6902455b3a.3
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 21:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780028521; x=1780633321; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RhdO/AEgSTmHjiBbCMxjzej2oiy/N5MjAHVUgamYaBs=;
        b=HN5BQ7NhP1CN0VJEp28hwT4ngfYASDZcMQSRQGnKWvQOnai9hCs0i5CbbEajaNXYq1
         fToN0d8fl53aJP4GrErBJay7A2pLbsJNz6fQdOiQ3czlsBbmQaSqmZ7S9YrqLRJY4hJe
         qWgcCFo8RJ7i1uYkFPUzIeMfK5LCXJcybwZxpAZRZ26DFJeAbGlZ7foUSXcag6xZAh8n
         IffU9AbdpLjOhhiUWgVlacANx4H0nEAE0j9AwXwV3f62K1LQAXvpSsF1husXEeK7vDnz
         R7SnJ3vYOmN5W2kwKQ7Coc9feue0ZbPeYiI5WehuceP95mFPk5EdGWiaYO+F36FfLTXF
         6IsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780028521; x=1780633321;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhdO/AEgSTmHjiBbCMxjzej2oiy/N5MjAHVUgamYaBs=;
        b=iuP+hWj27dt/GVN/WRBOJwchpjGsiYBGc1/r5sevMpWfMe2ugKw5IZSfgBBt+sMzUE
         NX0bGn+hlyEHX0k2He12rRasH8VWm/F7VKiz7foRV3obwfZXucHxVX7CXemj7QYrXdUq
         tT62urGny9SOnyhTLKMDlFQRW4u4lACc7MTPbbX+LjJXdRPh2VVknKkCrIu5Pg7OjFCh
         yD3gdBl8hKTXXgkEaEFajCtAiYh5ZqJfXQuUOmqSZBiQ5Lb8mM1z/97NBoouSp61t1Nu
         yxMLFGserRFuWc8pBAKvPmEqELzi9A9pEyV4dBApmbnaQu9s5vDcaw6cNxgPDodgEVQy
         OXxg==
X-Gm-Message-State: AOJu0Yy1mPbIRdfxeMQ0cpY/2jq6Br93VLQiOg2/iLnG3NyHbjGAvOi0
	n71XqZP4GDibUNQwuvRE5VgF4CzLTIz+lkDUGiohhwH8Ytx2oBypWhzD2TLhfQ==
X-Gm-Gg: Acq92OGis8hASNM0gAQmydN8cN3q4OjPXBoVJSOvniPWZLtO69560BxOQQrtUlUvabI
	zohbsr77PYka/3y77WalHlroQ3hGeWlYkTc3WaFWR0OanDQBFFhulOfL4IoROZ7dLUnEauvIqX+
	JRfPqwEOQGECBKWP518nWCORMVaUPK2dHfmKXC6yHIUhzd1wikGY0aMdHSNxvPFQGQO8rtocJkc
	WdAm1w2skFpbq+pqoenRi7LJ4LKal0JoVMIAjEK3p0mNM0cQ8BBaXGnitekixCWq3uMVgGiFnjo
	zyxDBHpS1Mw+djtGQtFfCIAtsjQH4c6LurMt9/EKH5Sg7xQCGOQLITDEvnN9wOMM5ZZW3r7MO33
	oaTgSni9T3yxwiDcnyUIKc8KzaQuCsrAeuj0LJn9oo+O1Vj5PbVVSwN3phApCK8PXPVx9Q7cw60
	SHan7CCeODi+K9Qgny5kT+uixMvBr/Eufr
X-Received: by 2002:a05:6a00:bd82:b0:837:e9cc:d470 with SMTP id d2e1a72fcca58-84212c5b1a6mr1241630b3a.20.1780028520687;
        Thu, 28 May 2026 21:22:00 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214cc35a2sm352288b3a.46.2026.05.28.21.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 21:21:59 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [RFC v3 03/10] KVM: PPC: selftests: add support for powerpc
In-Reply-To: <20260527133246.26D501F000E9@smtp.kernel.org>
Date: Fri, 29 May 2026 09:42:28 +0530
Message-ID: <eciux39v.ritesh.list@gmail.com>
References: <99818a9e1c8954ba74e1861dfa2bd5eee19f4f86.1779885589.git.ritesh.list@gmail.com> <20260527133246.26D501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

sashiko-bot@kernel.org writes:


> commit 4362b48fc35809ad7a74045c726f7ffae0c70ccd
> Author: Nicholas Piggin <npiggin@gmail.com>
>
> KVM: PPC: selftests: add support for powerpc
>
> This commit implements KVM selftests support for powerpc (Book3S-64),
> including ucalls and virtual memory for the radix MMU.
>
>> diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
>> new file mode 100644
>> index 0000000000000..9846ec26a32aa
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
>
> [ ... ]
>
>> +struct handler {
>> +	void (*fn)(struct ex_regs *regs);
>> +	int trap;
>> +};
>> +
>> +#define NR_HANDLERS	10
>> +static struct handler handlers[NR_HANDLERS];
>
> [Severity: Medium]
> Could this static global array cause state leakage across VMs or race
> conditions in multi-threaded tests?
>
> Since this is defined as a static global on the host rather than a per-VM
> allocation, a new VM will start with a zeroed guest handlers array (from ELF
> loading), but the host's handlers array will retain entries from previous VMs.
>
> This appears to limit the total number of unique handlers that can be installed
> sequentially across all VMs in the entire test process to 10, which would
> eventually result in the "Out of exception handlers" failure below.
>
> Additionally, if multiple threads concurrently create VMs and install exception
> handlers, would they race on this shared host array and sync corrupted state to
> their respective guests?
>

As of now there are no multi-VM tests which creates VMs in parallel.
Also the powerpc exception handler is not used today. It is deferred for
later use when more powerpc specific tests will get added.

If there's ever a need for parallel multi-VM creation, then we can clean
this up.  Even otherwise, I think making it consistent with the other
architectures makes sense (once PowerPC-specific tests get added), so
that too can be deferred until after this base PowerPC KVM selftests
infrastructure lands.

-ritesh
