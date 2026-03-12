Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1AB3F54AD
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330631; cv=none; b=e5j3l5/YMIpSYe8g/6M8kHzkieGqGYUNSW/dp7rdrIIoS4LSbRmsX5Dn53dSyGb/kkb6Z3DbU5MJwmxAI8vKiLQbMM0lHHghlcF0YxXG7vw05rR/H2Ts1Hu2j7U+im8VFbKkPCNj4i1H0I18eTi7SDbt0AKznjZ1Igxi30Z/qVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330631; c=relaxed/simple;
	bh=tC5jgIfgSYCINxxdwq1QFJLb7O6ggKTCBHAstNbWPpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=erh+ZugG1VD3SNqvFN0OIhcLs33l+uEaE4S0S1u4R7xWHMlwiPElFQolgPauQFugbdcXRvVLAxRFCG+C+vzoXkfp70kuMCXxpEwdODhG0DAvB7KWlXPTh8++0QnvdN1tJWj8E83Ov3pDwFWvee4iivs87ULajcoRiH8/1f2vKv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w9hUVx8P; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w9hUVx8P"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aebfa0af7dso50319185ad.1
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773330629; x=1773935429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txfJ+wO+omwjZcR/mS0HcpAn6dOJzbxTz4QO7lM4xaI=;
        b=w9hUVx8PTtdJy/jQh8tMtOlcBenBTwI1AOG2AGpfWnZ3jH5h6geB8bVXXHs4MsiT5Y
         ZhQCT4LLkhbxAaShvlGgPBYQ8Ul1ObaduPFMiHyzUmANu1dA4fuaiazXu3tr/s8Za2Ip
         ze1pvCo0wqnCkuPDcN5USOnL6VnXNvZuNPD+tnSFesG087imbTWY0ItPdiHs6u5Y2fwz
         EOR9DpplPmtmz0OA8NYB9Jto1TkQhEwYJc3WXvbNpgKF8Mng05lo3JALvgwWUGunL6QJ
         AChBpUxq3rWea3u0trNT5FqKRVm404HobWDkzibG43wKYG60mgm6uMLU/80TTE/R3zPT
         3/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773330629; x=1773935429;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=txfJ+wO+omwjZcR/mS0HcpAn6dOJzbxTz4QO7lM4xaI=;
        b=tyMPyZHEenrWzmqwHvX0Xa9zCzJps5ltnsPOWLugK4XmQTe5McrVc3wd78k30Hgxv8
         OYj6vIv59f4zr+0kRx4RI4VCofPTzXFQ8ucHYILNh341Fa2F+5YfE5Aa8WHmjyLbTvyD
         7eRa3XcJRTE99WkjJgxw+UlgCeT3jx1dEzAn+qntVATqm1FxfxMG6IWW4RAV+Ci2a1UF
         B5s2M4wpDuQ8KDxh/fNmK0gfaTKlbZ//ZfwWvp/YGVE1S3QRpTYw9/jLzMhoVeSv3wRl
         53/fekv9100OQ4wpxO1H+Ayj/OVuc4Fc525lYdFfT2v3BI8nfbla4OoabXNqisQyqAWr
         wmNA==
X-Gm-Message-State: AOJu0Ywt7GoQAXcsEKNlCxMpsKC9Y1B7CsyyKx+4koZ8tFWMcCR79mjW
	0OIccgn0kceBbfK53+AFO/ujdP6A4ucNgHPwFAIDECNPW28QcJ45jhXGISRMDOXry3D3gPfgQwP
	a+L5kMA==
X-Received: from pgbbx3.prod.google.com ([2002:a05:6a02:503:b0:bdb:36f7:556f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:431f:b0:398:92ef:1d95
 with SMTP id adf61e73a8af0-398c5f3e2dbmr6363198637.21.1773330628648; Thu, 12
 Mar 2026 08:50:28 -0700 (PDT)
Date: Thu, 12 Mar 2026 08:50:27 -0700
In-Reply-To: <CABgObfbnKz5HpwXMW+TjLRgQbuoiga2M-cXJ6no=K8hFsd9MCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305193053.1643463-1-seanjc@google.com> <abCLG4axO2gmpBb-@google.com>
 <CABgObfYY5GVF6iubP70jmCYj+3cbsYc7DCxiRsPRr=JDbZjQmg@mail.gmail.com>
 <abLHkWQ7ib8m1KhV@google.com> <CABgObfbnKz5HpwXMW+TjLRgQbuoiga2M-cXJ6no=K8hFsd9MCA@mail.gmail.com>
Message-ID: <abLgw1j1W4N7bsf6@google.com>
Subject: Re: [GIT PULL] KVM: x86 (and a PPC) fixes for 7.0-rc3+
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026, Paolo Bonzini wrote:
> On Thu, Mar 12, 2026 at 3:18=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Wed, Mar 11, 2026, Paolo Bonzini wrote:
> > > On Tue, Mar 10, 2026 at 10:20=E2=80=AFPM Sean Christopherson <seanjc@=
google.com> wrote:
> > > >
> > > > On Thu, Mar 05, 2026, Sean Christopherson wrote:
> > > > >  - Update CR8 write interception when AVIC is (de)activated to fi=
x a bug where
> > > > >    KVM can run with the CR8 intercept in perpetuity.
> > > >
> > > > ...
> > > >
> > > > > Sean Christopherson (4):
> > > > >       KVM: SVM: Initialize AVIC VMCB fields if AVIC is enabled wi=
th in-kernel APIC
> > > > >       KVM: SVM: Set/clear CR8 write interception when AVIC is (de=
)activated
> > > >
> > > > The CR8 write patch broke SEV-ES guests.  If you haven't already pr=
epared the
> > > > PULL request for Linus, can you apply the fix directly?
> > >
> > > Done.
> >
> > No?  I see the pull request in kvm.git, but not the below fix-to-the-fi=
x.
>=20
> Ah, I had squashed it in directly from the original thread.

OMG, -ENOCOFFEE x2.  I even looked at commit 87d0f901a9bd from your tree, a=
nd
the lack of a merge commit for fixes should have been a big clue.

> I have now added on top the testcase.

Thanks much!
