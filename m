Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23414219E8
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 00:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074185; cv=pass; b=QTaEB54mOQvDhJve2gBj7C9cMqbFoTPqgJYbSFDLi9cSNOSGi9mK5FGu7MZ4wH5jAZ2HAwFOkcLBECu3aMVt8ttqdsUOHMP35PjiIj6YKa+tRFGWNz1WF19dTY6QwtNMTQ8PW5wTh+qbtujKpDaBnUf2Eg26rtBp93tMZvTyMrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074185; c=relaxed/simple;
	bh=/Posiz6SyHI18ZzNxfW2MMGe/wdPnlrQImo+lR8UcNI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2ERnL7jyA8eiIjfz+1b8zerz3FFDGjJR37saoijAPMWFNNp6NW25mIREq48ze28wqD98KDeclkSxUg86Vj3NmYMGIuuYFUGWZwOEVoShMZ/Eb5cTZSXgGKPoKBNXRQJQ5+eXDmTBRMF+8q1r1V2L+w1wBLlpr07QIwh9qgw+5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sI8xp0Bl; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sI8xp0Bl"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso3417829a12.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 17:09:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784074182; cv=none;
        d=google.com; s=arc-20260327;
        b=gMRT7+4TumHxrxcm9y/iHUovLuXQn+b9JNppnEDotYQHqYDCl0OG4g9yVnH6UVY83X
         oynyxbB6Okym5MxWEqaoHWSULgg7tUdgAVxrTnq4/7rd7T1fnbCoY8JY7xJuoxAdR2au
         lgrUzbTzizCUEopjPNbMyt/q1dY6BFHdmAOMeOy7x6RLTJIoFIvEFJiMY3CYo76Ge+ZG
         URs/OGmYuT8HDamwZNqu11/NVC3tnFAJNe9SMt9GpwbxhL4ldPXV3no8AAS7IaFMIQrF
         8MNqn6K4lfHTWGwwkIMwhlCqV9T3+Nc77CN7DvVxFTfQkwMM7KBo2hWupVHUOVGK/8bw
         iD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=/Posiz6SyHI18ZzNxfW2MMGe/wdPnlrQImo+lR8UcNI=;
        fh=ejauVw2v2JC22nsitInIhki0uBsyhmGPpwY68+5cDUk=;
        b=AvxrY6aSeC4R+9Wf+XT4W89Jp4CmegsRTD3773cJxwWW8+bOvm6RVSfLHDSEMsm/lg
         BaS8/vapudSF3NBi1uysMb310eNK3OCiu7MJykWcZm0nIog/Dra3Oay3WjLNrfMP6pfL
         uo6Kpg7Y87xihwv1Nzc/KPiAwBgMdAppADI/FqxIi8Uh2h4B/Fn33hlbeXZWLfPBtMxM
         r1cYFqlN1qPCr809FihFyZWvPUJujeBV780xpvIa7S2tWKbU3L3SEVo2VNbVGh1avfqZ
         LYBJMUSIO4SYbzI3wqgGQkpa9wQ38biC1JP7PpGs2lgp7tkYp/KzQUxI7k2xk27jlukK
         uNbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784074182; x=1784678982; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Posiz6SyHI18ZzNxfW2MMGe/wdPnlrQImo+lR8UcNI=;
        b=sI8xp0BlxlkpIiMBiwpyMPXpcPhOcVBQVOYuhgBRJnqDR6KMZy3AoNHS8RPxeqnggT
         G4i7zHfec5LnFB1ai6hfo/xkNP6VCMEBGCol9glnP4kiD6ZKSaCTFSCtiIe6a89b9RZ2
         0tIs7W66QoLoEYacJaQgLh/RfMMpyEBOnp+IS3kxXdJzy0u/+0kVF4uXDvMDTj0YyR7I
         bXD235kext2M7+aNL7uLNz7fGDgAy9FEKdMv48Q6OVECe+J/N+ywzlxi91I8Bvw2klp0
         IJXoZcbWDv+Bg68VkQLfnzg2dILte3y0I0UOAY/mZyHxRpCu0XOL8R86FPHNkIshq91G
         10Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784074182; x=1784678982;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Posiz6SyHI18ZzNxfW2MMGe/wdPnlrQImo+lR8UcNI=;
        b=dWuXT9PM6Icj+jK+zBeFLfKvGMZ/wxQeb6BKydrjBilbt97IMRNqSo0X9udHsV70Bn
         yfLyJXaKK6n62gXe7ndBIiBLt4QnUqxNopl5taOddB7hj7hVhF0d+Ed8eND3+1gf+zyM
         RFmfNKSCx77veeLKdkJBa2MofyhJhEWTjP5AlQyQvxU7WuIfgf/Lrq0d+U4XS5v3WeLH
         Yq8z3lBsEbJgK+k4/MQozihGcbGBauY/7FOKJSk3MILcIka7jesoOtOt0r+wIelFsky4
         nspYySC1ePAbcYZPLey74YFIjY06PX4k27+K37ArRSbtXR5ggp4BxTnbKFQ/ZgTBiqZh
         ey0g==
X-Gm-Message-State: AOJu0YwbG/GWMA00GH1bxcVfnvQf/MK6B9xLvKfhJ9Qdevf6T+dWZ+j5
	9IoFzJz6/EZzfc9EGE8T+K5hutgM/3bFcg9c/IvcR5g23By9RybERJV9dqA4czLfgxmSYVnhb0g
	rUWyTzVm8j37YkFiR2hwDBVA31HMmSHFy4/CFSmhZ
X-Gm-Gg: AfdE7ck0HVVellh3scOF8ieQQnY7lTM2XBaeLFokItjIA1spUEjGUhw+loBv7agWZnn
	XQ6iaholwiqacMjK9N8a7w3ppTiL55fxQV5tylD7yp6AJnQL7S4e/xhtMhKtbFqEZ9Q2hQ1s/3P
	kAqvoqXVL7vthzFBo18kt4xi2gG/Gk/NjpKMHrSJm42V5T9tFykLZqNUYuX73bDPpJg9j/TUqKv
	Ikjm7+EsGQyl4Jl2oI5rCxGKAuMFhr3hXu8CpepwmjbVn7yuTsaI+kYLKCuZrVMXrpMR5nCvAOo
	LThSwUjO1RQ522qNWT5YhPWTNk92Aa2O627QHho+88CUZdqNbqN3o4ZYRzk=
X-Received: by 2002:a05:6a20:7344:b0:3c0:9c19:65b5 with SMTP id
 adf61e73a8af0-3c36c42b1ebmr706771637.61.1784074182038; Tue, 14 Jul 2026
 17:09:42 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Jul 2026 17:09:41 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Jul 2026 17:09:41 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260714231015.3337831-8-seanjc@google.com>
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-8-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Jul 2026 17:09:41 -0700
X-Gm-Features: AUfX_mz2v0InLZxjxyRyoHZNy0Kaohoxa7Y2asUmYCzSui5X52JB2vtDhTdcpZg
Message-ID: <CAEvNRgGCy5yqtRWT5vfa_hT-u7mu8D1wDGPAjPyx5qgKHHFyUw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] KVM: guest_memfd: Rework PREPARE config and hook
 into a more generic CONVERT
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Rework guest_memfd's "prepare" hook into a more generic "convert" flow in
> anticipation of supporting in-place conversion, at which point KVM will use
> the hook for both to-private and to-shared conversions, not just to
> "prepare" PRIVATE memory.
>
> Opportunistically rename kvm_gmem_prepare_folio() to kvm_gmem_make_private()
> to better reflect its role.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

Thanks!
