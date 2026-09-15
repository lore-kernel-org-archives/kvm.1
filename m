Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963FA43B3DE
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 05:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789450250; cv=pass; b=qnccSjpG9Orhzhnb2frHE24oLIMuMe93r3ymeg4wxrYXLPbYo2YWFxrR4ohK5jUeV9xTI8ow+xPJGOYQm57HPkKCrFp3pOLFrd2Vr9YUNIbKYhqLeQOvuNFN+deqUwBzH41M4WfPwFIRP7H4SYnWnpikxDIbJ7GpOXVBwDvU33U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789450250; c=relaxed/simple;
	bh=GJvMbReFrxMsiDsbAoAgzLzAmmTi8yBdZN/SVYhbIaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLCO3T+5/DbYqm0DPGEZf8Lwg4FmyazSYWpFYu6BMUXpbw2yKHROjqvXx1Zx07/iLwVQSQ8mHzuylgalH0gwDXH3Nkduvs28xJZ1p7klGBr7XT8g3b9e9HORFf78naXHVZKY99K2HIhl+3GvPeBO/He0JBOk4Sq3srw8q9aRBAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+YYKzuY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eje97ank; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+YYKzuY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eje97ank"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789450247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jdrymbp692g0D/7fa/VZXqFnszTm180HBQ+IpU2kX7s=;
	b=I+YYKzuYNnu4/a1AeaQ5dfBoEGg3JbAEgkIWDMhY8OEi+0U1gL4ovjDSfD0AjBy3Rw8q0H
	zhntFpjgVVHsqwgSRCv3CjOonSHvfoQrZWX4fikN/jVRWMkJdtfPbaNCn32DBUsrdnQ6E5
	pIcib3JR5QLfBsHdeW7s2iFUTJUprec=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-Q9KB444-PaOUs1DkuBrApQ-1; Tue, 15 Sep 2026 01:30:45 -0400
X-MC-Unique: Q9KB444-PaOUs1DkuBrApQ-1
X-Mimecast-MFC-AGG-ID: Q9KB444-PaOUs1DkuBrApQ_1789450244
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cf9df1eadso37708325e9.3
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 22:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789450244; cv=none;
        d=google.com; s=arc-20260327;
        b=Eu6HiV0pIz2uA+dFYof8CJUsSUj+oAC1OSjbEPpzoBFqhRruD+c7i0OdTL9fnYfUP6
         usagF6kT+7LocvDL/d1TdD60mfNFaNUMj3OIzBKsAU5hJLYNmbs4LIIm2BMMNysIaLlJ
         ZqouEBirDQ5CtHBwj48dcZBiU3ASw/b7/MBCFp87hkRxfNRHJ0cxK1ZT/XK/sO52WtnM
         axTHv7yuYE4lLdMCsmpGf8uLweroxEZhwAhzzDKcqHyNzbGuG73Axzex81+052mn6wBJ
         mnFt7+q2rFqX7JlGqMZhvIq9tZu8afbbfHc0Ei4GPd0m5efmsNq0/0SbWvx6OY/ahbHe
         tvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jdrymbp692g0D/7fa/VZXqFnszTm180HBQ+IpU2kX7s=;
        fh=aZsBoSFSWMRsBvqfLt4bNOs9iCzeY0qhMk0Yzg5bG70=;
        b=hEjzpNjJHYzt0ZJ3nb8QpkB+wkSYSIUaMnI9UQWh/Wmh7OhLgYhRqdpIFrIx5SjNyH
         R7JoAPYBiUTQCmnQSVXWisxQOhOQrhRHvul/aAlXyA3awgmviVj55HQ5rSGRggWQfKW4
         pJY0CeryrSlKCsNQ6hdS198GqPf3hzex/zZjvM6VdJ2mKvFXaqQHy03b4CFleJUWNG0k
         mDH9BghlMpZ+u32wHdRJgE7Cp5PC+nlz+XWHJB5zq2jTPG1d+KY43iHP4jHUNDOKZqmS
         r6rc8XDBsWSly3OmPNrF3/e1Ih195dkkn5ZxKWUtu3PpQxEOuATIu+b6LQASCNPd0dsf
         i5XA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789450244; x=1790055044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jdrymbp692g0D/7fa/VZXqFnszTm180HBQ+IpU2kX7s=;
        b=eje97ankMBO6QLyZPhp01wPX8IBUk8fLuDoKcSAOEblhXjcQ7mdogliKSHynJXFNoC
         gS4LJmhfULhOJE2NF3vc3Ycv5f7f2cYzebRdvCDXW++O0P6J7S7c4sDij6jIRqnEBrR4
         luXaGs3nvN5bgJdUmPeAwcaxqRuwIkNJgT8rLYFnZC0zRl7XscUvMmyMIbY3SRVK1yzm
         EWQv0yF7+kNmDpqi8PMAzPaBmmZiwaP2CYmO3z/Gz6yBH726K7p/gZ89y8siQ/yoPpl9
         R7wQFp4xlRQHEB2aWz8PT3zIfj7c3Sp4rDYz4QZWCFVjtRIN/Z/PEFQiYbCG5hDcbMJx
         fuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789450244; x=1790055044;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jdrymbp692g0D/7fa/VZXqFnszTm180HBQ+IpU2kX7s=;
        b=ki/D+0FLVmcyzEGQQeqGz24uzO9vRyGJQUffnlBGvsjX9NfIoXyZZ7F7RMvp/NrvM1
         vtQ7VqMXHkxdkYKDXG15LORuDFFIgDi5rtfjZGUqoZDF2EiNdACEitjkwURqmlfqjZk4
         ZWEuFiU4SFfYLsG5WhtDK3CufLqdTLeqEUwYdcQZxMI3mRUAo5NZXBhD2xupmo3dbnF0
         1pLzkBFjnq1kQhZsxQakUgwZ3NJw2J5a/xY09npIjv4yAOcuQpjometkfi0UR0IswFuP
         CJfH3wqYPfjqYo5uBVAGdroMnIiWf4r6gj035pDN4gXI5ckPvYDcIqunl2+duU7/RWs+
         HTHA==
X-Forwarded-Encrypted: i=1; AKwUvBxOFUeS6W1I2uusZ1vl5YQ+bIcE229MATDo1+raWaWcOSkxHyI30blX9uTngOwAxq3oxVA=@vger.kernel.org
X-Gm-Message-State: AFuF++nt9vZdUjcMcuNvrkZ1GX1F1ukReqU0TdqECqhkRIyHkSaop0oh
	LSb5G8D/E6pXPDFNTt9CqrBHo1iGGBil4FcX3nk6/3ra8BUPR1QUMokHzZDsEfPLe/KD1TtL65R
	DMoGl2ASOleaT4JYR1tBZ8D5qahUXxTAjhZjjbnvn5CFrBEtiQjMvasn4dgPjT/4pXk8514iJVu
	UUk6ChHX21YNQqFGCZlm2SyTuODZ0K
X-Gm-Gg: AYBFou3OOClxTXUBJm+i4zZukvbUxzs1bJ7k++SpFYniOTYsHTrV0xFFvrfX+OcVi3Q
	r3MT4rcvp4bz2Quj8llmIDymPfxhm46Vdojjy/6Hmdy6Z5NwRJ3db5nye26V537nIOJgj2QDrCw
	Io1hS7YsZssrRPJ2G0lQ1XwBDfleo+vIkC36iP565bXKLFThy1WpZkGYUSebNSpETD2aooprDDZ
	mYxownUwG12VIqBEjlZCDKMQHQU8Gdn40d8jNrvDLjL27sRULdr0RlBf6Okjg==
X-Received: by 2002:a05:600c:8706:b0:49c:fc6c:be15 with SMTP id 5b1f17b1804b1-49e7a68b749mr80684625e9.27.1789450244571;
        Mon, 14 Sep 2026 22:30:44 -0700 (PDT)
X-Received: by 2002:a05:600c:8706:b0:49c:fc6c:be15 with SMTP id
 5b1f17b1804b1-49e7a68b749mr80684285e9.27.1789450244226; Mon, 14 Sep 2026
 22:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914143702.915401-1-aharivel@redhat.com> <20260914143702.915401-3-aharivel@redhat.com>
 <aqgRj7mfDhCUqWw4@google.com>
In-Reply-To: <aqgRj7mfDhCUqWw4@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 15 Sep 2026 07:30:30 +0200
X-Gm-Features: AcwNN1UkoF2o0DlhmB8-mzAUNV53Yg3ZkBipi8bwhNsReywzDQzsiErSC718oDI
Message-ID: <CABgObfYcGeOekEKOG=nQEV+6Z3WCBt9rW33OPU7khNb_TLqWdQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/3] KVM: x86: add KVM_CAP_CSTATE_POLICY for per-VM
 C-state enforcement
To: Sean Christopherson <seanjc@google.com>
Cc: Anthony Harivel <aharivel@redhat.com>, kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 14 set 2026, 17:24 Sean Christopherson <seanjc@google.com> ha scritt=
o:
>
> +      Option B: Use forced_idle_latency_limit_ns on the pCPU.
> +      Same per-CPU limitation, and latency-based rather than
> +      state-index-based =E2=80=94 less precise.
>
> Conceptually, (b) seems like the right approach.  Per-task will be a mess=
 because
> similar to a KVM-based interface, it can probably only work if tasks are =
pinned
> to pCPUs.


Yes, per-task (option C) doesn't make much sense. If you want to bound
the tasks' wake-up latency they're either pinned, or all I/O bound.
But if they are I/O bound and happen to contend, what happens if they
migrate? The destination pCPU won't have the right limit set, so
you're back to pCPU limits.

And doing it in KVM doesn't remove the issue.

> And isn't abstracting away the exact C-state via forced_idle_latency_limi=
t_ns a
> *good* thing?  Without that, userspace will need to tune its configuratio=
n for
> each individual uarch based on the properties of various C-states for a g=
iven CPU.


Yes, even if you had a KVM interface it should allow nanosecond setup,
C-state indices really don't mean much.

Paolo

> +      Option C: Propose a new cpuidle API for per-task idle
> +      constraints (e.g. a per-task_struct annotation checked by
> +      the governor during select()). Correct for all cases, but
> +      bigger scope and needs cpuidle maintainer buy-in.
>

