Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A72F468C3A
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837503; cv=none; b=OYZKwvpURDc+43Sn0WTiVIMMgIiSLuJVCkBSIe0iFsP++crzwRLFtPTh++qz83CMMPNgv0HWGROK2bnSYNH1ye99DrYnHcbyJvqEF8iUmnaTJAVKqnr/zdrjNruJ3u+RrEha1Eh5kwRibvT/EA+7omGu/r6nNtqEP1LFO1DEnds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837503; c=relaxed/simple;
	bh=yELTqc/whu2ZyTt7q6V++mR1Ah4OLnSfIhMnB0UGToA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=uCYz7DvyeqoHq2MR/EASbHT80wo4432YhJc3lvawrsqaNRCOFMdlwLnJCdne759mZeDkZmAe/VhLdpRicpXWUOL6PpGlTZjIl5nwh8OJPmMiCqMaBpnOWZYKMv1AX9Uge3+eNpCvevTsPoBh6V69eZAXjavQW4Ow/Fu8Na26GKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1pSwJdW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1pSwJdW"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-482e257a23aso1197489f8f.0
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 06:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787837494; x=1788442294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qyby5UZjcCx+5Tgc+qhWvfDr6EF4z+GwQseV7CdajZc=;
        b=A1pSwJdWjSSCQu51RIppX199PSaRYiZg/+X0J+gU0jR919ZfvdNaeQwf8Jf7Fxg+Pi
         PV09TY6XHkfkh6HRF6ZKavY2LOvrU+xEzATenJxIkFzMnH2VTbewGEvjxDB93FoByQat
         OOOsDEfnRHv6l2hDUEnyIRK+Y9GRud0PTc53DG1thHH4argPwS3NkfDw5GZ7+EiBYoRz
         mJ7M8hBrFmbB6O8SAHd46qyvYiPA9S9sQIHVMwrkSa522ZVcA12BXo5aucRvSFoinZTB
         kFlCnYwMWwv8fDyGwCqAAvaO7eQu2y2o/rkj54o9O8t9gpvbrdBzCv6r1tGCHET5nPri
         6UJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787837494; x=1788442294;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qyby5UZjcCx+5Tgc+qhWvfDr6EF4z+GwQseV7CdajZc=;
        b=iAhcezvNBcEa+mAZ6t9c32H+wITFHoiGpDeD9UqmKXj4etIcgHkO4D4WMcqaYKcaME
         0lVb6XV4oOs/bQhrS8ov+3xWyuQEoNQo8kgSKgLbsHFlv8XTgNurms1DPH/an1n+Fyi/
         c1jkoY9Ef8uP4IkAMiknzD8uMSd+04vycdLAaM87WHgoVbWXtNOuBIw/s1X2w9sA4QTh
         RXmeiORrbO9UJNtr+2rKhiYiEG89epXzbQTT9pwLrwdycCOuVWG4pcpWt0/ngsjWX63w
         xGZGCsfMS1rFGVsIWApkESc8ts57aI+R0F01ZEdjerPwHRvIdzLfRaEwVi0IRtwff1bE
         ugLQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro1UTENHqdJxz2w5o0Z/m1miNQ+PtpzbS+rduBQaNoQrM+5SAk1EOYcqEZFF/5PlgRV33k=@vger.kernel.org
X-Gm-Message-State: AFuF++kSdF4YwLZKW6TrScCxMawJwKMsDi+jhPAJuQ77E+w/5riRBdok
	j7Q3HM+ueilAY6M7Nb8v5HOLelbCOnzADGYdyZRbdlH9KccH7Gj/DgrY
X-Gm-Gg: AR+sD13V6k8MHJV+Kv6tvPviWIFfD8R5vJqafeDzgqUFKz+bnXX3sLCgH1Kko8YwGWv
	Jo226eD8eYInUSH3IcyyQ3OLQnP/8niZZTEa3FDnl2XnTUrN/ClKHHZRcMn635p+vrZIQNcN7VI
	+qbk2c33I1wQkHGE3DqbFV6FUGYLTzP0Sr7ANvSTu6xhfdQrsxw6VTTBdak2wAAJ0+5CLgAINr6
	vBHr00s4ygoUWNLt0vDcKr/UUAMn3V2AfivMhXqVul6foB+S/jW3axw+z+JvKwLyom9JSvPntcf
	HDA7FYqYK1QUNb5/q3gzKOX8ZPOw6hbeHYefwEob+wAkaMaCV9MYfZZoulTsmksjYvV0HaYDvPr
	KDhBsx6zdhIYMGygS1kbjthg9jpZQv27X2OoUU2js4FVlrYZJ9C83HtZCcYqz8IVV/ggD88QPO2
	U0DmGdE86oXruKve9XCFAjF6+B34Rfe/gmUWZ3XklSZeTTwdqgBpOMHtNA9OqdfDf6o02m9E3DP
	65/+6uGkzgTzF8s
X-Received: by 2002:a05:600c:34c3:b0:499:93b3:91ea with SMTP id 5b1f17b1804b1-499dc82e965mr179956955e9.15.1787837493359;
        Thu, 27 Aug 2026 06:31:33 -0700 (PDT)
Received: from [10.45.29.112] ([15.248.2.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b8eb6ef7bsm28292645e9.5.2026.08.27.06.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 06:31:33 -0700 (PDT)
Message-ID: <41e1eee3-2cbd-46e9-9bce-5246244c5d12@gmail.com>
Date: Thu, 27 Aug 2026 14:31:31 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jthoughton@google.com
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 kernel-patches@amazon.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, mamarang@amazon.com, mancio@amazon.co.uk,
 mingo@redhat.com, pbonzini@redhat.com, seanjc@google.com, tglx@kernel.org,
 x86@kernel.org, zoumboul@amazon.com
References: <CADrL8HU2uoOVsOoxY9Sm2edV5-aXzP8QLL2LPShOF6bASpkfmg@mail.gmail.com>
Subject: Re: [RFC] KVM: x86/mmu: Prefetch forward run of pages on TDP page
 faults
Content-Language: en-US
From: "Thomson, Jack" <jackabt.amazon@gmail.com>
In-Reply-To: <CADrL8HU2uoOVsOoxY9Sm2edV5-aXzP8QLL2LPShOF6bASpkfmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On Tue, Aug 25, 2026, James Houghton wrote:
> Firecracker might be using async PF; using KVM Userfault basically
> disables async PF.

I've been working on exactly this series [1] on top of your KVM
Userfault series that turns userfault exits into async PFs, with
userspace signalling completion either via ioctl or this idea of an
exitless variant which skips the KVM_RUN round-trip per fault which has
some exciting numbers!

It's running in our CI at the moment, and hoping to publish this as an
RFC soon :)

[1]: 
https://github.com/firecracker-microvm/firecracker/tree/feature/secret-hiding/resources/hiding_ci/kernels/6.18-secret-hiding/linux_patches/60-async-pf

-- 
Thanks,
Jack
