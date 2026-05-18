Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3346838B149
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135104; cv=pass; b=s+VPeU/WIhMx2p8HzSLjvghHzhrK7aiuUmAR7tgQqT5qA09WfHyKrG0XLJhaFKGykBHym49fLbRdet2Sz23E8fG4Bl/s8A+tXf5iEjg5ey963eU9Qh8pyEYYHPOX4L5B6kXoK+3Qr2vBQ5KuciUlDsfuwNZNzZm2o7KJuWlqzfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135104; c=relaxed/simple;
	bh=9IEqR/JAOjfFIJhebyvyH/SI7u/QxKnr1MWrLw5MrgA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StpJiVCvmQh3Q1RhYjKXcom+4I8gyMkc+copjvzLklIg71mMkf0mTFWh+0rbw9eQt9obNLWVxqnNcgzYdbwFbdZpHBqm0dpXD3X4J3v9yRIVo5Vm5yoKzX78irkf2txs97+kc7GEJ7VoYANEuGbfKSWqFAgEoNSpMaw/rQO3eVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c52N6cjE; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c52N6cjE"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9568bae58f7so1809389241.3
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 13:11:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779135101; cv=none;
        d=google.com; s=arc-20240605;
        b=AeDk3KRshGPgI4WgdImxICF+hdtEcGlNWHhNpvO7n9zTtCp+ldhML2TMhvz8y/cxFA
         vzf22J1DFk/x9Z4wPJ2pwMsDV0iPuhom5MciXualyVY0bmoPxaYGPfekyz2kRwdo9UFs
         QLCM7yJld7pErjcQBMfeh/+/w49WEOGrcibRbIb7bVCVRA1NqzBgwTKiE5IcES3NKL5I
         KlhI+3seIIrYTODa663Xgv3WUdMUGQhggC1HPTZHOb8HidwqZkmNrSKcm425+Wv7EHQ8
         n6IifbElJhSuymmsGMC0YbSxQ4SMSQY0ne13wKFtzKvGi0oMmEVHhzEnYiQXyrfyO6ey
         dIlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=9IEqR/JAOjfFIJhebyvyH/SI7u/QxKnr1MWrLw5MrgA=;
        fh=4Gaj0FZG+dSstTQeyPMOUDojuEAQdlJF7mLv4rFJi1A=;
        b=jvb15DiCw5RxOu0+jgKoJ/KNysgFFyUiMtAIs+DhFAyvtwF3p2HWA10R4cq5cibB3+
         mw+ix5Iuc1NuI1B/XZzNHSCdj7cdAENrS1ir80G63DY06nuBujqwIsJXUCDO+pwhNjZ+
         PKy3H/Rph4wKx3pMPhcw4NcjiZKhmBnR7XnUo1BeIEvO4/CWEUavgLdP6dCpu7ffwXnY
         nyqONGAUYTwmfILrPvUziYwJl/KK2HTcnt2m++k6dJe6rBsMmZpAi4+fDAUOD4+0iG3b
         9I9lP0cohtAUaR6P0xUnFwjs1EDrDtgAL0ptQk8tv5bBM26d9GasU4MxWydCiyYVX9v+
         ZW0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779135101; x=1779739901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9IEqR/JAOjfFIJhebyvyH/SI7u/QxKnr1MWrLw5MrgA=;
        b=c52N6cjEaqEYeVIKFaWdAtF1aoscZkAHsH7UTL1abmzqtAI5aSjYbquA6Wj2wy5jEX
         VkWE2LH6tf1nycM393ndpIQ1gjPb6cr2pCmkmhPQXyVngRAbpUx4kys30VJcctcbFmqB
         9H9xw2h+zGsmIrYX4qfobr+4iE3S4epXjj6IrzL8uk5q6Cjadr03ZXtocNRurR30gOPf
         oGZN5J/mXd0N3AquoegKHQvfw503ciDn6h5RiqDLi2fVYz3B9S9Qsa9iKA4n41kRa5nQ
         VgIvyAiPkzggIDbe6UadcvGEh1JM7tUmqCUve+oF21wgHjmnpX2Pq/hHs69J+xRfhFss
         LDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135101; x=1779739901;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9IEqR/JAOjfFIJhebyvyH/SI7u/QxKnr1MWrLw5MrgA=;
        b=e6KMIx5pPx/28pJCV9xEVAPlGIPTBUDAgvUNcI/A4RQ/Lu7prFlcDU5eqa1ydcWT6D
         58ZiXkOPJyt2VV+f9b22dPgp4GbwfQLwxPqGHYJ9M5rBfUL/XKjKeWTkjRgMYJ5aujHH
         3RBnT2G6sCvajSMaBarVv+G3pUruwyBJ8XJhRFpLzhQ31oA5st1x7gTyF9gttRn2sdGu
         rxknEr20Z687aMslVhXZdtbnTQFpkq2ATGQRt1J5Ors4hL7q6+KRZ5/rvJhX1gSjyw9U
         DllxlQh5ljyibYp6+02qAvdOJOJT5xy1RL+8GXrUFGP1LrKj6I2TmTOlkuf16TccBlRd
         UTIw==
X-Forwarded-Encrypted: i=1; AFNElJ/iIB+Tbc47PbmDNN0gSPV9/Ou2WbzqDWc4CL6xl19INTHKmn08+cT4fJAyKNiKO7dE0Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya5lo215ysiQl6ADFiOD0Hrgp35IE5LrEUkpxmx6TsgwKUgA5R
	kmdLwytBrKS7CSYqi+Mn6SB2SH3wLI09UFauVqKJaHRFbtGKSLMb4X1qX1h7l43PcRMyIUX26v9
	v+BwkZpP5Lfpc7GjoXbKynoTxInJspC/UIN7yGK2y
X-Gm-Gg: Acq92OG8w33BobPaHuyId+foDO40vxj0WgH/PLgzQoMN0W+Ogi7LDYoZTzxOQUq3JjV
	STQmQg/FZmO5N+gX0Q4F35wtgARlGC7hbsdY0H0xLSEvj+FvZgKcScnAuVi08BswSMZZtxIJzAh
	6lhNhTwRhFqXBJUtXnVC7rokZTDk1gdmJKExp7OGcTYR5tYu9eIjliXGariAG62rPhYfcZzXN8i
	rhyUoE3ewHpZ0AmT0ZQaDxV4EZkyiIgK1TfTpKPnXYCEAsn8CJoUwbSjPP4K3gSlZuGPofCW7A3
	f4H5Pf2io/ViEn4Ctrxk0j0h9UfvV2Yr1lvls90LiOXVw9p7P4yX5N8MphS22ZdJU5w/iNR/48v
	yMipz
X-Received: by 2002:a05:6102:942:b0:631:ec2d:12bd with SMTP id
 ada2fe7eead31-63a3cd10ed4mr8833063137.5.1779135100510; Mon, 18 May 2026
 13:11:40 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 May 2026 13:11:39 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 May 2026 13:11:39 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260518070943.2091287-2-ZongYao.Chen@linux.alibaba.com>
References: <20260518070943.2091287-1-ZongYao.Chen@linux.alibaba.com> <20260518070943.2091287-2-ZongYao.Chen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 May 2026 13:11:39 -0700
X-Gm-Features: AVHnY4LMAx_y1X0yC87kI7cNrem7WpKVKfwQkhpaYZq-kTqwoEkCuoNA5KTDNNw
Message-ID: <CAEvNRgF3ow+k74tnQQ0rZQM9jfUMObap36G=HuxG9Yt2E+z0Zg@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: guest_memfd: Return -EEXIST for overlapping bindings
To: ZongYao.Chen@linux.alibaba.com, Paolo Bonzini <pbonzini@redhat.com>, 
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ZongYao.Chen@linux.alibaba.com writes:

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>
