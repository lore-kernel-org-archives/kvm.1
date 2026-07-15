Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189603AD51E
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784153277; cv=pass; b=rVZP6yi4NG81T+Qpy1+NE5nA1WDoM9PjsQWHS2PPJ5WVPXMB7Yx6uUVyHhAdydkKFPHtGeaHMDN8TpoAIiWiZVKx8Cuxne0Qr785kzyrzvnv/aWQtHhMrnH5r+WuPBAVZ4O27EH8zY1sEGh8FlesWyveuqKqQNq0urYVsa+Qif0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784153277; c=relaxed/simple;
	bh=ziZvIKUuEdmVOmH7vLITxvPAZCEiqaRZhbsgKfQGETk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k38ROViPUgYHVWRtvtuUsrdkqZ1RK0xdAvMAeIUWO4HpyVjmoTbw2Ad/ixkKXJ590f3aguU+EYClgNWl4dkdsip3NJjjtW6hF/1ek7LtxlzdYIHy+RZrjwwR/AdYstDvnuxktuwNiwwB7Ta2rPicrcwGxjcKwScT5ZitOE2vwQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuOFTg5I; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuOFTg5I"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c10e86e52so42211cf.1
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 15:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784153275; cv=none;
        d=google.com; s=arc-20260327;
        b=fS4OLmCHzkCJ1yVvWhC+Ernr+32BWTBooW3B2n2X+WvSZweWDbiTbodWDx+GQhFG6w
         MvyHYLcyGFGQm1/i6x5WsjwLLqmdX347522F7Mw94sfLamJa4EY4o823kstcscG9QyEd
         lJ1rKbCvoOXPqlh/Wjenj6OLZsB1lptXzTvxU5GUmIRrn2QklUaYelFruUoNEsUxF+Bf
         8VRdqSp4FbRBgmuZ3YZqX1mG40/irTVO3QIEQNJ/ycZSt4P3IbA0fN7X/5wRoipEczpI
         RZjj8ypn80Ojj0Qe/0WgRrfR5IPGdV4oUEBVaNPFwvti3nxkMJ8bfeclwazJpCU5JNH3
         +USg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mLq8CLVEwD53cc/U0aWxK44vpDeOe5OxEryrY7Nx/kA=;
        fh=m3bqy6UIDoWB5gz4Lb6f+xsAl5/VRRvuAVXH1NE8nTE=;
        b=EGeXLOFhaTtqluPH/uUJbmtG6JvQv/gQDVaUNcJZYavsdpkQdt83pcVy5ihgwgwRZF
         G3fU40n+xNCKlefga1loLq3QZaZ9FPS0UBhgH6Q7CDOoisFBOJgmJzT02A4T9/g9f94Z
         wVx8m1s/SrTcmhEKziF9X05liLGiJMhW3UmnHWHyd8p8lQ+zTgevS08Na/awPcWY0/Za
         X8JbpeJ93CneGYy7w7Z9F4w1WtbtPSL+ClIcaNKYKwtCXuf4UNYgTXZ3XAzIDFcq9XAx
         JC9ZfFK3Omk9/App+MfOJh2Sv89S/GU0kPJ/2p+PNDv7uSq01rAMovxWREsecZULWOkg
         yRng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784153275; x=1784758075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mLq8CLVEwD53cc/U0aWxK44vpDeOe5OxEryrY7Nx/kA=;
        b=BuOFTg5IKyCjCmENFdkStasP4Jt1WLs63Ks05hrl2pGbLZXRvFgr5z4synXE98OiAM
         f6w1dUrgY/oBDmecnAgnp2uV/2LXJI1J6kXBaQsJxl11sVafTMeeTQSS15UOvv4+QvrI
         imuWiY5YdzYjaFZUFsrHYlEZeZk+Ia14MIt/aG+SMnIIBPbkcxNROrxMrVwOOd19VP1k
         x5Nznmuu/t7Z2FJZDP3ZFWoeBLd+BAR2PAhLWqXeUGYe2Ff/IILMT21kduPNR2cUAvK2
         U8N3aQGG2n2Wlwq1jLI1Nx5w1UQe0LSrinb6EQRNvpO93K7YyotyQO/MLUccDgh3diK5
         aIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784153275; x=1784758075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mLq8CLVEwD53cc/U0aWxK44vpDeOe5OxEryrY7Nx/kA=;
        b=f7fORwYR2ReHaDRy2XFUJbbhciLAtJfA9qaWQXsoAuavkJv0JsyaK9VYUhUYVpxWfe
         WMqBqzuun7LmbR+9+ngF6/dtN58R6Sa6DvmzZJjdJnqi4O9u7QT2WOnR+aWTW8yHB4sb
         MHhKpGKQYJKF0vYZ8sc54J21k6agitlo+EOcC0ep+xnTV2vhzPbLRjsASdzU4IYDDKt1
         aBQeaqgUMAjtycU1+dlUjOLGSs6vDtpNaTry69GM6laLYieEJNjbP7lla9iX/mLvNVkb
         0yqZSAl965T0vdXZvsbXeT4917LtYtK/HZSV1t9Y2oMb0Zox1g2ZtDon47EaJ3Gtck1s
         agUg==
X-Gm-Message-State: AOJu0YwUjW2rXdLuNlJOwIq+uP0aKE/Flz4KW1IrDa5L+E2YoL78flTi
	cksSqqulkrRWl7WZ0nwp82zwmUPgYJ6Yhz7i0FCiMYyZlS6zBYDkp52SrFm0IZs5u9Gz0AgSTrA
	15cTSB4bdKPGQr5oDfyUqFBrCPOAMFg3EOog2SUpN
X-Gm-Gg: AfdE7ckJGQUEW8kwz3RHjDgsH4N6rUt239r7rHQvR0c0sY+AS7gj1N/J6y7lMVr/Iul
	1R525T6WwkD8G+hEE2ehTlOxVnXw62G4L3BDV8sDSEVTfYhcD5vpzd3z27xsJHPTnwvl1p41LUH
	mkOk4fXA1kVlF4OCnXJPLp2BpFMGUbuIIKPI5QyL1zhna9bWugcMGvfnheEaicnvXqXVhZLvf7g
	et3sClANHRnY1U8eEVpTtBx9w6JJuG/VgV147JCimMXa0jTi6lKGwLvqmWZAQ==
X-Received: by 2002:a05:622a:94:b0:517:6010:7c71 with SMTP id
 d75a77b69052e-51f7d273976mr2618491cf.4.1784153274190; Wed, 15 Jul 2026
 15:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714210303.3967981-1-aaronlewis@google.com> <20260715181133.GE3775915@nvidia.com>
In-Reply-To: <20260715181133.GE3775915@nvidia.com>
From: Aaron Lewis <aaronlewis@google.com>
Date: Wed, 15 Jul 2026 15:07:42 -0700
X-Gm-Features: AUfX_mwBWfVqXbkrK3PnZ_zbujawqGP1tbru_OityoZPf6M21deHUUdnZPzc_H0
Message-ID: <CAAAPnDHkJabsf7haMLX7bp30qxcbXc_81y8mw5t-3bNWdm4LmQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] vfio/iommufd: Prevent scheduler warnings when
 unmapping large regions
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, dmatlack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 11:11=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Tue, Jul 14, 2026 at 09:03:01PM +0000, Aaron Lewis wrote:
> > Both the Type1 IOMMU and IOMMUFD can be guilty of not playing nice with
> > the scheduler during DMA unmapping on large regions (e.g., 256GB). Add
> > rate-limited calls to cond_resched() to ensure this doesn't happen.
> >
> > This series was tested using the selftest proposed here:
> >  - https://lore.kernel.org/kvm/20260701203311.326798-1-aaronlewis@googl=
e.com/
> >
> > And profiled using the bpftrace tooling proposed here:
> >  - https://lore.kernel.org/kvm/20260630141152.3757722-2-aaronlewis@goog=
le.com/
>
> Given this is the same issue on both in the some place, I wonder if it
> is better to try to get this series done:
>
> https://lore.kernel.org/linux-iommu/20260603151804.1963871-1-guanghuifeng=
@linux.alibaba.com/
>
> And put the cond sched inside the iova_to_phys_length() ?
>
> It would be fine to do things in steps, like add the
> iova_to_phys_length() that just does the loops iommufd and vfio have
> today with the additional cond sched inside which isn't such a big
> task.
>
> Jason

Ah, I think that is really what I wanted, but I proposed a solution to
get feedback quicker.  I'll wait for that series to be merged and
reaccess if a cond_resched() is still needed.  I'll follow up here
once I've had a chance to run these tests again with it included.

Aaron
