Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212213AC0E7
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082217; cv=pass; b=gR5Z8fl/xf4hiYNC1g3jlsoeYuzt+1SyggOh2sY+I6wiwXudGr5O03xF07tnMfsF1TqvtS5gpf56flfwX1JS5fL5inRggcKP0th/s/oUiXg++yuna7dSsvsU5APIzBKr1NvKiVbwMl3d+kFvmPSqTTWTck2oeFAl5hx/QWDlkfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082217; c=relaxed/simple;
	bh=d0l7uKyUGAFvL6R4w6MO2qwL5tFfxbP6Pv5jSvZFfDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nabt1wLEr2TLPps3SrxZ1FBCdH+cNCNv9Kb8Z1be0DYSrQYmgVWjBJL9JJjuGkbrClb57Lder2qh4BN75IFMS+Y0Ulg+SFeWJcgydCS86EcFbS3UCaaGT3B/nQ9Zfl3GmTJmhLVRfoVNYWJ8bGBvfD45d2ootjlLqHGn085Xrso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U92OdsVa; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U92OdsVa"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6501d32b04bso3980181d50.2
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 05:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776082215; cv=none;
        d=google.com; s=arc-20240605;
        b=DHiQK8xawtMd1yKX1xqqzEUOA6ySBkkOkqrE7tOcjJFjlofHAHchyeHXdAUXi+5epe
         rJsYL5cmdxqL5a2Egooidc6ZBcEXH5PnI2j+6DWoeqG4YeMlsRk2hfE0W4b+7IpWLbDD
         +v71s8QzKVjuQK07k61q2rSv+a36opPTBAJdsT6StChyYRkgqIaqc3duhlxjfPb7N40x
         mb52b+i9yVNwfFX/DoOxf3N/qbsuMpNNo0ickUJHdDjKYraOLnUwZDYHSfmPin6+4Pjv
         xBocrZwjvjD0fvQdneR2G1tT7pWzXQyqNqQdAVgS1qg9aetP+uaFo4cMVJ6WBfZseqxR
         9fLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=d0l7uKyUGAFvL6R4w6MO2qwL5tFfxbP6Pv5jSvZFfDc=;
        fh=RMneE2X0tIF3OOzmtXdJCXgNg/PTJx00iAuzUOJYCBY=;
        b=VjmDR7yvVmzrB5lMcLh1pApV2iw9kRqyep4is3s03IGJ4oknEfQ+YgEWFS8SjNIHqm
         FBC5HSCuD9tbPo4jLSC+96mrVz7AMl3oo6Etij8vziMJqr5YTFj/5PAGA7eIX0ZkH509
         /VN1hQ1TeP2XxN5Bsq2jupN+qBDil8BzOZMkgAVPW9hG6jaNO/gfZGv6+TJwv4a9eAIJ
         gT3VB4tVZeKnIFKnV1+RaryfgzXCcB3af7mpMzaZ1/+34GiwVWWONffOQKkgevgE0LU8
         25vHMDc1OOT9zV7BIHOAmlIVgucuu7BaH8IBqREuu1mZvX+5o3+urK5HWsyjKoRenOTy
         wbvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776082215; x=1776687015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d0l7uKyUGAFvL6R4w6MO2qwL5tFfxbP6Pv5jSvZFfDc=;
        b=U92OdsVaUqyFO8eemOt6i9Gd2VWT5rPeYcFgGwYLp5ngA0EFetY2zWly9Dbf0rDXdU
         JAUyu+zn/NFIaEhpRX+bp8vlXDHZlKb7Bo60V0UeMEUIOKZfallAMqIJGSbe9lMlf0BN
         jlzp+NpYcoDA/A/n6ZToYMmeBWEtEGp6/q2FNNzDCUtlqk7MHBURpIrpYXP95wObOKHD
         JTQI8CHs9vxA6LbCSoRDaHK0CPuvdhpLSqoahu1N6j3KnCdEpJ2oXuF69m35bsXPgv4f
         CvMUYzg69Z63ASWnpM052LFMg2LcJbvcrycue0RklcrZ30jnaJ9cfPEJWIY1Rs/YrEmL
         JPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776082215; x=1776687015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0l7uKyUGAFvL6R4w6MO2qwL5tFfxbP6Pv5jSvZFfDc=;
        b=jdVcn8DilY/6as1cxsdUYMtp4ntYfUNWOqqTPOV5dM0QJ2N1tHseG6D4WnyP9xHoSE
         KAu3HvT4baxIfQOFs739KRLOs59rqHZ7hNOZi8mP9OuS484npgMqiqdQjsQPL7UEc4MZ
         p5BYN7ICApJierinsD5B/LhQC6x6QSEd5k2lIKmXy2nMUSA99AN1e/04djChZSCyMOAb
         Ib4Te4G3vluqGKMtFXyLow4YTOujM8ce++PHzNrF7g1M0k2Xv/pJK0DKNuhUsf99UfLO
         UMDESKTVl5Bvz21eotN2rFtJ8YHIziA1mUCHWD+MUrIC6vr8P+lEvsDjuKfP28ViPlSX
         T90g==
X-Forwarded-Encrypted: i=1; AFNElJ/8M0YsA7oagevrX4d4sv50EEIdYb/+dfP0vfXtYmFWnLTjLnlbKD05M2eQk4eHrZJMF44=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa2eESA1oRvlu6AYnyre8jP/q5sUUFkUHLmHInUY+MFBGZvToV
	z10NL0PTSM4WSJnxVWkyke4TH0EPCshq1cnSUErRlrPVusnMy4oQdt0fW3am1ljJHvx6Q8MoaV0
	IM1lh1KQP9yfzfLcyjGtAyVJZAwTbF62tCluvu+2krw==
X-Gm-Gg: AeBDieu0OfyPcs0rKjf49H2JSaizSwtRXXL7ODGUeqkeUaz3zIiGhUyWLJ75DgmBZzb
	SnaZeQ/kZTMHPP5FcVJWevek+GjrQTwdvQY0N5lR596WR8qTlDnCz03MgRIwhEO55k3Gcay1zCX
	V5HfQEz9MZUqWF3cz1G1gtNfvUkMVcCiSTSgUjqNteDAZT1knCGTr2Dcb3mmtCYgTCybsrHzWyu
	as+y7jPZZhiXZVIU8zD64JAheMH7fzKjFrTl6z3rfBS1Qu3gUjL6B87bic3c4MIBscLI2bcWiN6
	LUX7blB9fpo/fHFUnJBv/vQJgDpMzrImsA4qOM7RTJwV3ocFF+2ovoZGOXUlXxMOjUQ=
X-Received: by 2002:a05:690e:4841:b0:650:211f:1d4 with SMTP id
 956f58d0204a3-65198b82095mr8882405d50.47.1776082214947; Mon, 13 Apr 2026
 05:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413090010.60339-1-anisinha@redhat.com>
In-Reply-To: <20260413090010.60339-1-anisinha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Apr 2026 13:10:03 +0100
X-Gm-Features: AQROBzBUIwljeF7bsJTwC19zV3JnLe8AM7zwfh_wplD60WBQv9RPuRuBSo4bXGw
Message-ID: <CAFEAcA8CcD+8Hn2++X5FnyYcsDLV4J=tFg5BAd_sRJmCw+nVkg@mail.gmail.com>
Subject: Re: [PATCH for-11.0] accel/kvm: return early from kvm_irqchip_create
 if kvm does not support irqchip
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Misbah Anjum N <misanjum@linux.ibm.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Apr 2026 at 10:01, Ani Sinha <anisinha@redhat.com> wrote:
>
> During refactoring of kvm_irqchip_create(), the refactored code was returning
> early from do_kvm_irqchip_create() function if the required capabilities were
> not present in KVM. This was not translating to an early return from
> kvm_irqchip_create() as was the case before refactoring. This is because,
> do_kvm_irqchip_create() did not have a means to notify the caller of the lack
> of kvm capabilities. Fix this by making do_notify_irqchip_create() return
> EOPNOTSUPP error when required capabilities are absent and then the caller
> can check the return code and return early.

As a fix intended for 11.0 at this point in the release cycle,
it would be helpful if the commit message stated what the
user-visible consqeuences of this bug are. That helps in
identifying whether this really does need to go into 11.0
(i.e. whether it is release-critical).

> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

as the minimal fix for the logic-bug introduced by 98884e0cc1.

thanks
-- PMM
