Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A779405C5C
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152467; cv=none; b=OQIc7bgVQo5/fk5vext/IXbMn0ay9vA3qJExN2e7T685OqDNWQg0Sndm9h0Jsq2Q1QUAafPlI5DTlx+55gRmFHxPM6z6h1Z+SQY9DPxDq2Ea5iScIIr9Ph20/J9WONV33z9pZX7dk0u72pQ0uygsAYjZy2J2ccY5OWmdYZ1IWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152467; c=relaxed/simple;
	bh=w73//z+ksqLYZY7XAV6NM87fwXUCu0O1TweAlcOUwYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iDoImSBJ1QKGH7s7SkmxlLW4MbS2DErfKPUAvt8nHq+gdDs4biIWNDIjnM86f7uVtCx1mwb1ywKooAVXuHYOar2H0mybAUsHYvXN40ASZ0fmNfWmN7zS0mr/uYGvmfa1Lxby5BF7fwfRKz3xyD5EU03B72l2ClpMP0t9ZjZXlVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pCaZ1ps7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pCaZ1ps7"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f85179263so4593227b3a.3
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 18:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779152466; x=1779757266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w73//z+ksqLYZY7XAV6NM87fwXUCu0O1TweAlcOUwYI=;
        b=pCaZ1ps78imKzEB9NS+XNI/ugLU33HrXqMPzQmlqBkBwiR8bG5gTjpVX4LcvQnjAKY
         poGjV1UJVDWK3r//jnke3nlt/lbp6JahZp1Nup2h+E5rKcv00HWJXWbkYD+wbAS7v0jA
         KZ82uQZGLdKf2IWuOcwzFml7wRdtuF+bqjO4lTtS2Bn2KLa/wEEaHUFICM10uOj5xbJp
         sOKU1tRDtjno3B4pyxiCVR0tn4QOxKzq2ErNiEDodqg06m6G8Y0XAgx9zeL+RiiS7QkG
         GSqcNW1/6BoXmJXBFulP1pyIm5DcC3vkwLz/gNLntASVIN4w6cltD1uVGEssmlkVAtaR
         dTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779152466; x=1779757266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w73//z+ksqLYZY7XAV6NM87fwXUCu0O1TweAlcOUwYI=;
        b=QwF+Df5apT7dqpHKR1L10rjXtvlxdfoyTHJFLX06bExImM2oKVv67HAQlx7rYUgB/0
         RGpao7Kdm7WqBgOHiiYHCpT+fNDGvfJbPNTp/RdMWILFLkhIUt7zOXvjJ6xtk0Vd+6or
         X2e+YFEzTXxbIIWxk64yPKS29wCCoAdnBWui4X55vKUAZ4nZgf+LJ5vm8HSPUl0YflVo
         5WxK6xn/pNhTZpF5RX6EVYC6RxW6a03PQFpcS28dL+EbPUmF1jREoS/H1qzYgtbYBCrv
         qD6X5by5wqz8P36zenUU+90yB8pc+FWPKtim1idjHfzkmtRxq1nM/Ns57WviafwIm8dc
         uS5A==
X-Forwarded-Encrypted: i=1; AFNElJ8f76kd0Yt+2Lsu8LesL+CFR9DoHta3mIoq3RxcEc6G4Wi1qZeQ6USgF79nGkDU9Z5u+2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyucdftepBfiI8vpa4DUHWLXV0WGP+2fuXbJeBB+nB9xRv9yWs8
	AsyxRqQK6g+bz4nkQ7Aw0bPGMLB7laOKF9bHy5Ab6UGBotlHPnf8e5BCzkcj22vzhZHkxRafFtq
	vIlTr5A==
X-Received: from pfiy14.prod.google.com ([2002:a05:6a00:190e:b0:838:dc32:5349])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c0e:b0:83e:d52c:e6bd
 with SMTP id d2e1a72fcca58-83f33c9bc80mr17829172b3a.38.1779152465512; Mon, 18
 May 2026 18:01:05 -0700 (PDT)
Date: Mon, 18 May 2026 18:01:04 -0700
In-Reply-To: <20260518044150.34632-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044150.34632-1-gautam@linux.ibm.com>
Message-ID: <agu2UAi6lWclxFYh@google.com>
Subject: Re: [PATCH v2] KVM: PPC: Kconfig: Enable CONFIG_VPA_PMU with KVM
From: Sean Christopherson <seanjc@google.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, atrajeev@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 18, 2026, Gautam Menghani wrote:
> Enable CONFIG_VPA_PMU with KVM to enable its usage. Currently, the
> vpa-pmu driver cannot be used since it is not enabled in distro configs.

That seems like a problem to take up with distros, no?
