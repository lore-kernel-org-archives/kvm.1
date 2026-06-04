Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1807368D74
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601731; cv=none; b=P7dNaHphOoANgT2CulEnL/Dc1tRISDXQvF4N5LCLVEBpJMhN89MvfFoC88XVNEC+tVueJpajYDEeSj29ZpKRcOsvE+Nrxm0+eG03Y7nWAYIoREcpfnDpwLwIfHDPU4HBu7Sn6EMVdhzaYtW1Dx3tajGOI3BnPYfkFK44bgsiMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601731; c=relaxed/simple;
	bh=1YofZpMtmmjQnKJt0AyFwdSGGDzL0tWdXXGyeCPJD5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S/JQrWV9bIr8628VYcApFoL9kIkeA2pZCtwjUJpPzcDHYrf6ovk/7xptek3slQAVzgWuMV5h4rI0cnp3ClmUXfhyxTrBabJiDo7XuED1ik+G2QMA8g1ga1/AZqI0iDqUsxy5BEiAwfp77r9gCxdTtaRXqDXD9Hg/kuJJlt762fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mTQ1DiI4; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTQ1DiI4"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2befec3fd8fso7776145ad.3
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780601729; x=1781206529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GNHuzQnVw7DPfnDwqoqnw8wQUPfIpTU62drof68ZIpc=;
        b=mTQ1DiI4ydiJr/5kaIBGZmMlUoRIoiY6xvj04WNJGYaTApORLIYwkX87QftEvWRVkl
         Rwca3oXQRd/vzqwzad0k6TT8ceas/ttYYjEuZMa2vODhZs5JUcnswDlBPIzU8QV/VInH
         UCQaaL1BM6XfLxvbEvazuZTjK+/bKRkeS5YMDo9Zvjrjo4yD9n9sL3pQHMSoWtLML2Eu
         HMPJu7NWzUyILs0AKrbAgpC8vBZ9tIHn3fT4tdIk0I2JIodILTMpbiLpmYXnDuXuJmlr
         Qy56DbHSJ2LiTKje3Iyeqnf/uCmcMo7654c3Bch8bfk2/ERq4FVMynlOdDNZaCpmzvNb
         UAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780601729; x=1781206529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNHuzQnVw7DPfnDwqoqnw8wQUPfIpTU62drof68ZIpc=;
        b=YCUCh66yFY0H5cpa1NuTKOkeXIUt766rn78gEukAsZXTIFUvHUKYl33tuA48Hg23yP
         RY0IYQD+kpoNT4BTEQW4eeSniwL8UUN7bS+Gl3x9K3p5JBeA3wdqL9LmcoqYA4XvK6W+
         wTG2y6pHAmg1bJLSznNQT/JpbXzDna5fX1lhZIhWwURXzonUSP5oUNSyvvpMIbn612FF
         0Zr9mtt65j216kWRDF/xGdGqeGd43kGvBUGSMdezhkV44Jb/2yV2XQkS/3tSyUYNCkU8
         Nmj20cTqBS8U3k2ejjsMZNC1p3ipvSGfIXkgcNvYGRJgmxKCUS7XD8lwltoDYW9Hrlij
         5Xow==
X-Forwarded-Encrypted: i=1; AFNElJ+je01iLCBPHJwaB9jjKwj1YdXzEMtboeIdimEf9xb0+7IguVSqNr01Fwoyo7H4OfVWTDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMS7LwYk3QUTobqwvrw4xBqnbwlkyu83yEcxPDHFjfhzdPe/BZ
	3RfSvdPPLc0+NRJXDrKg17zbvAz8I2RvqfIMck8OpzqFocZHy2W5Gz56Ckj1giU4WNpUWw12jMj
	xBRoepg==
X-Received: from plzv5.prod.google.com ([2002:a17:902:b7c5:b0:2bd:1ca5:b928])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ced1:b0:2c0:fa4e:91f6
 with SMTP id d9443c01a7336-2c1e7d41eabmr291435ad.13.1780601729026; Thu, 04
 Jun 2026 12:35:29 -0700 (PDT)
Date: Thu, 4 Jun 2026 12:35:28 -0700
In-Reply-To: <20260604020143.748245-9-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com> <20260604020143.748245-9-jrhilke@google.com>
Message-ID: <aiHTgDO5MekPQ9aT@google.com>
Subject: Re: [PATCH v5 08/21] KVM: selftests: Add helpers to write proc IRQ
 affinity for IRQ test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Josh Hilke wrote:
> diff --git a/tools/testing/selftests/kvm/lib/proc_util.c b/tools/testing/selftests/kvm/lib/proc_util.c
> index 84d30f055a0a..938c90d94f4d 100644
> --- a/tools/testing/selftests/kvm/lib/proc_util.c
> +++ b/tools/testing/selftests/kvm/lib/proc_util.c
> @@ -38,3 +38,23 @@ unsigned int vfio_msix_to_host_irq(const char *device_bdf, int msix)
>  	return (unsigned int)irq;
>  }
>  
> +FILE *open_proc_irq_smp_affinity_list(unsigned int irq)
> +{
> +	char path[PATH_MAX];
> +	FILE *fp;
> +
> +	snprintf(path, sizeof(path), "/proc/irq/%u/smp_affinity_list", irq);
> +	fp = fopen(path, "w");
> +	TEST_ASSERT(fp, "fopen(%s) failed", path);
> +
> +	return fp;
> +}
> +
> +void write_proc_irq_smp_affinity_list(FILE *fp, unsigned int irq, int irq_cpu)
> +{
> +	int ret;
> +
> +	ret = fprintf(fp, "%d\n", irq_cpu);
> +	TEST_ASSERT(ret > 0, "Failed to affinitize IRQ-%u to CPU %d", irq, irq_cpu);
> +	fflush(fp);

As Sashiko points out, this is prone to failing silently.  But rather than just
"fix" that issue, this can be simplified to avoid the complexity of flushing
buffers in the first place.

That will also allow fixing another flaw: if the caller passes in the wrong,
file, debugging the resulting failure will be annoying.  I see no reason to
risk that, it's not like opening a single file is going to meaningfully impact
overall runtime.

All in all, just this?

void proc_irq_set_smp_affinity(unsigned int irq, int cpu)
{
	char path[PATH_MAX];
	int r, fd;

	snprintf(path, sizeof(path), "/proc/irq/%u/smp_affinity_list", irq);
	fd = open(path, O_RDWR);
	TEST_ASSERT(fd >= 0, "Failed to open %s", path);

	r = dprintf(fd, "%d\n", cpu);
	TEST_ASSERT(r > 0, "Failed to affinitize IRQ-%u to CPU %d", irq, cpu);

	kvm_close(fd);
}
