Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAAE2C0307
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775586098; cv=none; b=u/WfZUFvhqPq78UUUkJ9HhH23zZi3wYMOiO57JKu6tZYiqtu8opRONnIp2cmYC0Y4tHWoVdyC+tyw4akeyrtVq4W/nFVyhtLTvlEi6YorRcZf6I5axOUiHyjTcyblQ+O4e0O9waeXa8aVTYLFDj7AJI25OhTTtAU8fH/PuHfn8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775586098; c=relaxed/simple;
	bh=cNG5rL3dDRxPLhf+AACoCVJhDq+QeKTcux5ursLDaD4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LZUqqRMbQtFnAiqLQvwortjp1vrou2cX5kLNNobLSpRonoKpVPs+DYU1Jkf9V9z0GCB99AcxgoR6job/1vWmMmwxTyTeEUg4BCtgy4ntI08QM4KzlCxsaz+yKJQf7i5sF0n8F5jslV/nKBSVvUuTR1XC1q6sJR367NcBu8oEuNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hP4r3Mc7; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hP4r3Mc7"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76b6db8bb2so2455686a12.3
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 11:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775586096; x=1776190896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quW+CKXHXogXGxCCnQqcA4P+X4VGz9VRPN6lHbJRyAI=;
        b=hP4r3Mc7fYLzDvNJlbahG35SSHi5/GbyUzUC9L5gLwh7h6uMNZ742SDtdb3rqe6xya
         iYkdi0DxUBvdvrllOYGU+jxVxJGSmB9BIk/q6AfV7u3yufP3hl9k7uhdvUjwCIjvyEpE
         gN+BAevAhlyPLfQtdRMstkmWDmhnJKSkkP3tCWjidAn2THzlD9cfeAI+r39XXanoq41n
         +kWY3JtRRJBeol6lyQpYfR66IbIY7SObcEftCY4lJ0ApNkkyKy0BVCo7YsiFEzEyiTl3
         5kge/QZ8T24eRcUgh/1pdqaZTZ/SDxn51hLlzsUvJp2hJ+79fBYqOq+RLrVTrQB6ZS/G
         QW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775586096; x=1776190896;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=quW+CKXHXogXGxCCnQqcA4P+X4VGz9VRPN6lHbJRyAI=;
        b=YP4R8qXZBjiU5VXtT6ijbpdMVrq5vImgXBnXrhUpE8YTMxn71yDUmelgAVvtgCm6IX
         cWW3kdheMlVHztkgDK7SrQrz4/E60ChVIeB3Z+Nq0YPzx1rC2IGVDD0I2M6BY+jKvM7w
         +sFX0/2s9FQWAkGDD6chSbwdMQfBZPPwG2jEVnC7Zh60iBQGEZakAUS7uyXOGx3KxvW5
         3UeqzIhcBzP3DyDNWcvIPb1shyIBRJW8jebrGHlD1He+WP5mOVCEX4ACOqFpmpXL+IwX
         rjqV6cd+lxSDE5rLpDlDoUpDynZt31VB6HgYBpXBJEN5mQKHMi5Dg1WMhfJVa12ycz0V
         aNMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX0REcgvNPQobDc0eVdvnhobcSUHaawKaSNnP2g7sC18LLx6DkRNYNRgJiMAMHpTlDb/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8qNrxyalbgGrZrT87n+o2vhebqgdXilH2NUIKgqVK0TSAO1/
	CAx1T895YA7is32E7Xm67/rUJ1kpQl3HEvam5SL6UnUWE6VHKJMzyuHbcF0aajmSwGpZ6tmvY0W
	IbYPdaA==
X-Received: from pgbdo2.prod.google.com ([2002:a05:6a02:e82:b0:c73:fc44:8ba7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d8b:b0:39b:949d:6078
 with SMTP id adf61e73a8af0-39f2ed105f1mr20018287637.6.1775586096240; Tue, 07
 Apr 2026 11:21:36 -0700 (PDT)
Date: Tue, 7 Apr 2026 11:21:35 -0700
In-Reply-To: <53f20505-df88-4311-8bbe-8f0fd3012b4d@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <c820e242-9f3a-4210-b414-19d11b022404@amd.com> <647abba4-8d47-44b0-9e11-b3f1d04c408c@amd.com>
 <2723ab8b-8fad-469d-9ef2-918358953b16@amd.com> <c5f86b40-7330-4ff3-a2df-90729d1c9fef@amd.com>
 <524fc5dd-e06b-4857-82e7-f0a969966bc9@amd.com> <ac1FT4G_VpFHRIWl@google.com> <53f20505-df88-4311-8bbe-8f0fd3012b4d@amd.com>
Message-ID: <adVLL0NKFN_2rPND@google.com>
Subject: Re: SEV-ES guest shutdown: linux-next regression with QEMU 10.2.2; smp>1
From: Sean Christopherson <seanjc@google.com>
To: Srikanth Aithal <sraithal@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, KVM <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2026, Srikanth Aithal wrote:
> On 4/1/2026 9:48 PM, Sean Christopherson wrote:
> > > - With older host kernels (< next-20260304) + QEMU 10.2.2 =E2=86=92 c=
lean shutdown
> > > (no hang, no termination message, QEMU exits normally).
> > > - With linux-next (next-20260331) + QEMU 10.2.2 =E2=86=92 hang at the=
 register dump
> > > after "reboot: Power down"; only Ctrl+C triggers the "SEV-ES guest re=
quested
> > > termination: 0x0:0x0" message.
> > > - With linux-next + QEMU master (or 10.2.2 + cherry-pick of 56d89db2c=
fd8) =E2=86=92
> > > no hang (the termination is converted to a guest panic instead).
> >=20
> > What guest kernel are you using?  Bisecting to that commit for just the=
 *host*
> > kernel is baffling.  I could see it preventing KVM from loading or some=
thing, but
> > it should be completely out of scope with respect to guest activity.
> >=20
> > How are you initiating shutdown withing the guest?  What's the full QEM=
U command
> > line?
> >=20
> > Can you also provide the OVMF image?  E.g. in case the hang occurs in E=
FI runtime
> > services or something.
> >=20
> > I want to get this sorted out before the merge window and so would pref=
er not to
> > delay root causing this by a week or more.
>=20
>=20
> The bisection was actually performed on the guest kernel (not the host).
> Sorry for the confusion.

LOL, that changes things slightly.  I reproduced this on my end (finally bu=
ilt
a new version of OVMF that supports SEV-ES).  I'll take it from here.
