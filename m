Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945A5372D7
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087677; cv=pass; b=km36BsbsDR0gIMmGa6iJo4NvEurE1D+BCYAoOadiN80GgBH1/wDk4JfNLfQQT2lKsEjnA2C5Nlqm7G4vqUH7JvPyRUbiR6W5UySg8rhXGyADdNml6mhokK/tQM9OMTG9QW3rU4zuEZMzeSz2qj1dF90njfd250y57dwP/Q34g9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087677; c=relaxed/simple;
	bh=Cq7RZHzjEhO7/GK7BwfTmITx4s5PfiqDYhtEgS/Go2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3BKH92u8HvpVUbv++HweQ1y2bGGqdLnNP/MrDu3Kp5MA2oghYN6x9ZFqkO9ADnoG4wY0WT5vrqbun5mbVjMv4dMKn3kuXxuvQmloayrxlx9AZZhwQefHKvHSiTiITUa/a/BJVviM+ogR/ZcvAAl2S9G97YVbErd6bz9mdPNoYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R5i8XwVx; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5i8XwVx"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53113d72966so292781cf.1
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 07:34:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790087675; cv=none;
        d=google.com; s=arc-20260327;
        b=ZJigyFzvo/uMQ1cFFlRCnAGS9L8FBtJ4nET6AAH1pai0alKKtoP1jAq9GAKANWNSvw
         2WSa+8KOAHMoP1chAiSOj+bQNlwoInzbw6MFAgsugucnKXdQrecHbc/SW22dE42iuzKC
         lt2g0NyxrCE+7cr0rkbJRBB8kRtMR4vr6qYYkLm6W87Kl09J9swnu18WV+jED1xOFCmY
         egbvHEM/al7aG4AQdQIaSUvrBliOrQKlGEwsEqRjHuzkvMExZLZ3bwg967ZqrhBfRxOk
         dzucliA+AODklUcqC3LVhT03efc7GUNd/OncqhbUKdLL23f5REGUUQHGDzxtshfkdCkw
         npAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DExhxA44NC9dc+8kUBRuzxjVL7paFNIoFs9ji4voJt0=;
        fh=klYP++iOW0N8dXRPGy2jw9T2P8YLGSknan4XbSkg3lI=;
        b=gzT2g2jHcVg+yeSDJTT7KWDszc2xGF4Mc363pV1yhT0XCB3JkwRA4Hp6moTwLMyfvu
         QU+gtcyxl4C1R/g+8YtXj/o7+19ZtIBQOVTUnmgiynrXKpkIa7AHe+JgU688iPpO+zN9
         3kOdFIlXWwZb55+649E7xzmDU8j7MkcVpZ2ZzrZibUJUDNzKUX+0ruVNPpe/AgQnPPRQ
         jPlp6Y+wV0RlyUfqKbjSoRiWCIpJ3Es/PzHYhtn3gNVKVKxlCe/jntxUJam/FcfoSjNu
         QFUQk/x91Yko6uuQG0McbPTc857Anhm1aoT2jSg7KwHa8F5ZqeFXfnKTnr4lyzI8Ot+M
         Lemg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790087675; x=1790692475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DExhxA44NC9dc+8kUBRuzxjVL7paFNIoFs9ji4voJt0=;
        b=R5i8XwVxuPW1IdNarmfu9CW9jXTWOm4tOKFPvhwV22BF/GpNisU/wW6c9W6jwtEtKV
         UQ8SJ2+j4TaH07ZVbh5RTRY+Eqdpt5/FQr6zE+0d+qzhOlZ+LAzvlORZQxWYRf3i17yu
         SUNf2A8cq2+7S/OHNrMFcNOYNRuKA2n4RuAf/Q/GAeg7LIOxctDOj9ACHNL56P2fU9Ul
         chjUfuFV7ag5f4i5AB1flEaVGUkv6iGFjhjhiQ8rkkVDTlj2m3Y0N3WtvSnphJt9wIUD
         rEgdYLOMIiXdoPOChUvw1gmYS643zothqH6gslfyIMwCfgvCtvcpQNhTldUY5VFR+AZ2
         0O0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087675; x=1790692475;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DExhxA44NC9dc+8kUBRuzxjVL7paFNIoFs9ji4voJt0=;
        b=H+AMHs1HNSlIsFlnt3NicZ8Qm9DUkwhXYuvc8vTIzAAxw+6nc4uXjIY6IjlEAFMboW
         84cKrfgOhq/WBzSjqs9OjQ2iUaK44cuU7W5SqQGkVNguPOXXSjBWzyPMgr5jg5b2Kg22
         rb3iX1UHW17+ACEct8U02Vzx495S4OpMRcIhb2uUY+uZJ3eDDQWXeRn24EKGS91HklYA
         e3nbR4M7vmosmxwF72MBMzQVc+jSIjzNs/TPTHrtOws0eL5Z9QYFm06BynbH9zFuH+LW
         CURykuWTztkLBEP0Q86wpyQO/5Kq6gzZN6q+xjpCDMKUwtGqJ1is3Py7UwX1Y0sUv2Di
         mgsA==
X-Forwarded-Encrypted: i=1; AKwUvBzA46XEmy3UGHcsrsWrVChGUCkVKjE8Qzvpt+OCA9QA01ASRc3a5mTTnoEglsKxcnpp/Fo=@vger.kernel.org
X-Gm-Message-State: AFuF++l+2JL4TPoXiG3jy1M3+gfxuh9FP05MkuhHQn/1w3g9x7AXzHBb
	e96LTi3TDqjUmLg508sifnNitmQgjzwx0A+XFeZdGxR/OL2avfHDaKfv/5xaZmweUtnef5mH1Al
	vW+IRATKhQj1I4gPi5Ogpgch5J31ssGERwSp8XV9D
X-Gm-Gg: AYBFou0zH7Cu/ReVif8hljYkblnhSRh+Iwa+DeoKDfMgDOSwUU9tLQsRwAdV9t2d7y5
	8bHur8fQ+1Vsf+HlaYFVChAxDO19ZLHtufwzYOhyCJmKDUzk3OxtV/2S7cOgd+JbWbX4qc18Yla
	/Viz/Jispqc0nDryvWa+d9Pha2CsQbi2gAkKFGJXzyEucfkr8hnvAyZysHyA/OdXl3aKhTNIWGR
	uunDRczrc4tbZ0q0cTULSeu/XZuqQdXbxtmB077BZrptfZ1HxMAmbiWidgHylsharRnCdJiETnr
	89FqNQFVwpJDILdZyTGL/Y9rf3OKf5SGBuBHDuTr0zPopnLB4iXY5Dc=
X-Received: by 2002:a05:622a:1487:b0:530:2f98:cebb with SMTP id
 d75a77b69052e-532e861cb49mr1554881cf.11.1790087674052; Tue, 22 Sep 2026
 07:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918154530.4129698-1-jmattson@google.com> <20260918160109.E76B81F000FF@smtp.kernel.org>
 <arKJQwAPvApkeESD@google.com> <CALMp9eQboC6DTQfa3N58XCfOLf-qwJ2L7dC5vtqDerHG80eZLg@mail.gmail.com>
 <arKQJJJB8HMK0B1G@google.com>
In-Reply-To: <arKQJJJB8HMK0B1G@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 22 Sep 2026 07:34:19 -0700
X-Gm-Features: AcwNN1VJWL6isQaEKZnB01QFvujmP7sTdhriqRJAFl1aOntJ7hkFaVL8gFh26pE
Message-ID: <CALMp9eQi0gm7ojijfKDZz9oZh+BK13qUkJOFrCmxjJTr5sx3Lg@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Disallow EFER.LMSLE when EferLmsleUnsupported
 is set in guest CPUID
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 7:26=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Sep 22, 2026, Jim Mattson wrote:
> > On Tue, Sep 22, 2026 at 6:57=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > > Gah, I hate the negative "feature" bits, I've gotten completely turne=
d around
> > > multiple times trying to sort through this.
> >
> > Me too!
> >
> > > IIUC, you're trying to "fix" setups where host CPUID.EFER_LMSLE_MBZ=
=3D0, but userspace
> > > configured guest CPUID.EFER_LMSLE_MBZ=3D1?  If so, then Sashiko is ri=
ght, it needs to
> > > be declared with EMULATED_F().  I would even argue that technically t=
his isn't a KVM
> > > bug, because KVM won't advertise EFER_LMSLE_MBZ in KVM_GET_SUPPORTED_=
CPUID on such
> > > hosts.
> >
> > I'm trying to make it possible to run a Rome vCPU on Milan or later.
> >
> > SInce this is a negative feature bit, it must be retained if the host
> > reports it. That blocks running a Rome vCPU on Milan or later.
> > However, a defeatured Rome (which reports LMSLE_MBZ as 1) can be run
>
> So, a partially defeatured Rome?  Because it sounds like the CPU reports =
LMSLE_MBZ=3D1,
> but then still allows setting EFER.LMSLE=3D1?

No; it should not allow setting EFER.LMSLE=3D1. That will fail on later
platforms and would block live migration from Rome to later platforms.

I want KVM to abide by the guest CPUID bit and disallow setting
EFER.LMSLE even on hardware that allows it.
