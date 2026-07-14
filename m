Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B9B2F39B9
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 05:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005929; cv=pass; b=WdxonPmmjSJ2EiMfIpKP9MDmxmfPZjPYwQXOO2pjjEQxkRN+y2qK0j8nAjH+zRY3azTJIKBmsArSdysy/byd72U9vJL76561KfUcX6XoGm/L7eGyCzRl0xJY43mBNtRPOe94Zyl0/txMIxS2zLBiP+iugZgYfLaUUfeHDqX9juo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005929; c=relaxed/simple;
	bh=9qvy67cNgQ+ZYuS5C6FcWR0dV5LSa8wvl4pzAuficFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdVNn1PoARbQs2j9Yto6pMc8LNj1CkJm86pEegmYjs0fGti3wQMChQCgIa+oA/HPqLPTYdcg3nHzoZKOInxih0ZySzme8i328EeubrHO0bBQdm5dSxXiqn06ZcOfbJkZuzEur6Tto0E0muaYRvLuHbE75ps7GKz0GN9g5qe4Sog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t4xgfrlc; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4xgfrlc"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69a45011a92so7253a12.0
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 22:12:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784005927; cv=none;
        d=google.com; s=arc-20260327;
        b=YAEhbWnEjJULaapiRt9Bl2t57gxqsxss2hkj7SU9agsUTPV9AMYTr/5zpX/xnYaXoG
         bH55E8kf7y7Q/GZZK1Qa7G0Qq2GfMD0CH+SIeMZJOwJRTg+kQempOiAG+maxshVCkVWz
         1X9/qSfYVx8XJ1hfvzeMjbDngI78KE7C5nqdfmtpTN/4ZVRaepKRglFWSalECGreR4lD
         tOy7N8iu2NzfZnC4yKLKcHY53xmRUiciyuTDHWvg1vDI44wIsTNiuii7dj6npBPHVcQW
         AdbIPzhUwVq4WJ6OYSOGDyRoPSwGcSzxJVqxK8HaNZglZi5Rbr6d+bi/erql/A+uDdqj
         qeHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9qvy67cNgQ+ZYuS5C6FcWR0dV5LSa8wvl4pzAuficFA=;
        fh=xXZgTi21n9IISZYZozpMhEcSEcgoQhdYx4jtNcyEbVg=;
        b=nwJdPxJn88DYVHaNM2ZZe0WNFHa9agywFruE3ZqRlMokfk/6wyAIDZMkjLslLFnYHj
         Y7liKzyufNomxMFFlwjiSj5+6rbibDC2ZzyVLx73dKUYQ10Nh6K3KbQ3ynhJcTWQauqy
         dvSybfUrVGsXColW+nEeqftjuic7fjuRT+wvV4ZlEccQFs9l6aKdv4pVIMhyNB+b3mdm
         a8oQzzjDQy/goYZqTRsHPMczwIvP9g/L/DdZHkN46VPHahLxceuFGEeIhF0pENliysA2
         oo1BvjQ2LJ7f3+J2ds5AQmt2w58Lql93P+HJv9HBESzZTrOCUH4QmIV5ix2gs5tbma80
         8BDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784005927; x=1784610727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9qvy67cNgQ+ZYuS5C6FcWR0dV5LSa8wvl4pzAuficFA=;
        b=t4xgfrlcaPiEEDPqRkb4Ph/FnKbUbsr53gLsT4HwMUkMpSHamWP845P3DxhJJpSAPQ
         uqPQiRUQ4ohJTEVgQeP1YYtj8uQ3vCrvj9y8t0v0g97K9INIiBo07UIadPAFWegkg4sa
         wAY+FbqIgwe2ot/0bs7vBOiGxw4P+nLw0nsyuYPTixfAZaWEos9d0HyLwDdO04rFOJm4
         4yKzwj230BEDpCYTHG1/EnSPYl87omiwFc2GDlayRVBBdE1u4qI/eiAQtCdkXkdqcxMF
         3uv2eTh77my1StFmS30Zr+cbJgy7LqxuGNCDQITr4fZKYxfpunZoG18H75YYao28dPtb
         7ERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784005927; x=1784610727;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9qvy67cNgQ+ZYuS5C6FcWR0dV5LSa8wvl4pzAuficFA=;
        b=BrFC1ReylS6UBddum0FamO9dMK4PCxflqZ5h04NY7KS3KlKTsfTakTL24WqruTmm6A
         cafeB5dsUw/2GJV1225nUmpkei1qVMq9RFRixcYiacEPZwjPXwJF5gHSyr5rS0FcuFr2
         roMbi2gQujf02XJdOxi0WZNhAB32NKR6ZnA9qd2XokMQSMGWWv4OJgoR/iBJOy+at+XL
         sBCEPoPTLalw400wq2OAajJN1U3Xrb04bHeq1NhFxzWcgm9YvGcdKUEAMFzYKh57mawH
         dqO2YoyFxSL9jmZBFd7Y4D2PzcMtGFj/F9YemA3LvuJDUURJv8k+p64+of4r/9oy3DVK
         KB1w==
X-Forwarded-Encrypted: i=1; AHgh+RqkJ63xNMpee3mLWk7L1+ZU6T1JZFukzc8cg5K03eftoekm59wZ7HLBbkYR51MZg1+/YmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxzvSDlL1fPcr/DAJentfQ3rLB3g9FXs12zGH3obK2CyCXAnrg
	ZgrJbAWJ+JoF25QpjIYPylIlaFp7gGyF/ScnkQUWsDL2bHScw0lzUTNTTEsPu06IADL4oLeopuu
	gLgP65dFouhkxljrSQYo/gD5tx63OAlkUVApc82xlG5TVml1izSNJSfj1
X-Gm-Gg: AfdE7ckPS7ob3xa+2DwBgMi59kz7qmW5+QSjRd30AA6E4/KQ4wXFtWHtbUdCb9bPPzO
	tNbwuTtdjrbwdEhbK6rzJmwsNBSPxXh4yE2qn9nZTQsHo68gpa6R2BbCbr2aZrgTPb/a7rmGguQ
	knkCpI/KqlE4iKyQzlipWYQVX8uQ9YyzFSm+89W1JGVYX/tGBrZ1PTplb54/4c+WJb3XK8F6Ypy
	sBl6jwbtWmzYcJAwSphdijc82WP4wwhbfjXcSCfzwkPkjC0muCzCXq6V6k83RupU6BKzSuU
X-Received: by 2002:a05:6402:a39c:b0:697:e82f:e4f2 with SMTP id
 4fb4d7f45d1cf-69ccf08bba4mr75612a12.4.1784005926380; Mon, 13 Jul 2026
 22:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-9-zide.chen@intel.com>
 <32a1e1d2-c437-4cd1-8455-43fa9082cb50@linux.intel.com> <CALMp9eQR4rFTSDMrOSHsLXsKvTdm9BbhorMEK329RqRk5Rr7Og@mail.gmail.com>
 <5760cb18-739c-4907-b582-60933d11a72d@linux.intel.com> <CALMp9eTs1A73DUDQwO_mHDQF8UfJQG2B_GgJczdu2uxdazG+KQ@mail.gmail.com>
 <212b058b-5804-4a00-a95a-67f58546fd9a@linux.intel.com>
In-Reply-To: <212b058b-5804-4a00-a95a-67f58546fd9a@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 13 Jul 2026 22:11:54 -0700
X-Gm-Features: AUfX_mw3A7nk_-l7d7COjSrrbDbKIPAJpJqRVNaHkfNIqIqetbm4IDQwk1kjHGs
Message-ID: <CALMp9eQGTde_nbCtHN5E4GiuBKrcKC+Sq_6O_JoyHZCaf+S=rw@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] KVM: selftests: Add PERF_METRICS and fixed counter
 3 tests
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 12:12=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:

> rdpmc is the preferable way to read PMU counters since the better
> performance than rdmsr, and most of current code regardless of kernel or
> user-space already use rdpmc to read PMC counters. If we set the rdpmc to
> interception by default, then it may cause extra performance hit.
>
> Currently I didn't hear there is any plan to extend the rdpmc to support
> more types for Intel platforms ...

Is Intel willing to commit to that?
