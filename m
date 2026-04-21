Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0904523B61B
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776814485; cv=pass; b=hM6Ia21RlR0EaBMdcVGnxGrTtMvuAnxGhdv/nzMRo/XhteH9fTCyLSyXbiEc98PMm6vrrISdj7J2+Ir8jwvhc1zK75YnlhHZlD96imjPNNZYPe5l6xKiHW8T33HLgDo9LRHtiq595IMfXSpUOrj2oE/LKyUWicOTWw3U9PWOpzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776814485; c=relaxed/simple;
	bh=0x06FmnZwMy/50kwkFclJJa4WtXa2VYKic89kMQCGQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDdqqFhj7CDP/AG21xdD8a4PvvfyBH/ENPZ8x0detxGcmNysBEr29kp7kFyjT/9OqhNdyXW9AnSHfiZx/DI2oINYn9tHH36nL77uRSscJ1+OmBZbHKzUlsm+RFMqjIDvQTtrrX9ws5FzfuDuzT7j/lkWBUendFDVm4bAPoJ84j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+qZjPX9; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+qZjPX9"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so35561a12.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:34:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776814482; cv=none;
        d=google.com; s=arc-20240605;
        b=axtH6WcJhaBiOeyp6dtt5+aK3HGcFm0kHpyHiiBThQ6/ob3c5yFZOh7TPyImvLiy85
         E+fqAZYcmH5n8P5W8qi3ocsggJ+G4j4nU6iaC0GqJOXSy9eY/rBbxp34kegtY73JZ5Ci
         HM29EbjA5CM87FD4N3IyD/u5Milsmp0IxoOoi2yeznbX30Gz0a/6AWPfBjRkaH4+2bVN
         L3F5PoexZl5XfWkqb17Ap2kTqzr+F6wPZYzx4d2P2XEGGOHOB08vHB1eCHvchYHYpnlj
         f/eNSISos3hxG7JqxhxlGNOqjfgGdqbplGBHamlvXqZOooo4AjBywjzaIqv7BQyV7kfp
         616A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0x06FmnZwMy/50kwkFclJJa4WtXa2VYKic89kMQCGQ0=;
        fh=9+NgjjNfFMSEG4iKwWKz/7lMnO2b930Za5kYtyTk7lc=;
        b=icOu6AJtDSgkjZJLDNZgBLucwSJ/ex/ynY8TD/EYAqEvCiCqZAeR/MRcVxitLU0l0m
         E5/WHFYBzRlvnFADgLArFr9P95H15CIXPOIx7XZsl9qW0Y1+VwqkGu3H7FX42UKGxvGS
         mSzFtbn4hzVbG4DRoS10bP7hblSkYH8QBA2ktMrv73dMuPF/mjoZ45JbWQg2IrGv/iWs
         oGyaVAMj8l6o+ijJsjXAmW/NKBdTVX5QuR5MTbOw1XBdQveBuRFjJF0VRUmWHgNaKCfr
         jbQSALRqV21fYuVFh2TBEFJbjIhDI5cVxHID502olASq25eVeUm2+hu3jv4q00uBM7ni
         n3Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776814482; x=1777419282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0x06FmnZwMy/50kwkFclJJa4WtXa2VYKic89kMQCGQ0=;
        b=f+qZjPX9x0T+zjwezZ+9dFF7DoWcUQWL8yZ66CEm4DoMTmxB1LipP9jX9CBxZQiv5k
         WDUw7iFdUR/34h8Htp4uPQhyIXV7ni5LXWnDSyzmA+9UmIXOLAuSvGxIZwhYNm9fcyNY
         0XfSHbzKh5fBEbWbmiyAJz8Z5oosRLGUN8JOxn721mbvVf3uaC+iEYQXB3WT3wC0O6o6
         S2+P64qk3qsZRBn/g0RQLneXXrfMP0ybHPzy+A4Lc2RLE7TKZUfg1OoJ6lMu9sOXGG0v
         Cj6p7q7jDk+Ey4vsQtt4gV8YqlXTlsjGxlNkbbOHzds9xH8g3+kHkQQEg8tQ48S3COkl
         J29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776814482; x=1777419282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0x06FmnZwMy/50kwkFclJJa4WtXa2VYKic89kMQCGQ0=;
        b=Zub62tYQ4DubULyouGrxRnLukksHJyUnAw0qV+dviUGKY0pM8qzgeLYwsrczo3D4wW
         gnJfd3VnfMYDZrGesbJ7SD6pGbSCr44cGdpAySLwconjZqTivk1ZljCVfD1AltJeWTNz
         6BLSSJ+0xXOiMTf1wKczA0JtH2gzcSsaWUKpOe52VVAPq2dFh0RZHCoFFeOvNX6/jjZ7
         0tTY+jcCb38gQQZ4dnxngqf9qZA/MbQigwosXW0/IARfK78nBx/PVaeHFuAOQtUsGbv+
         S5M4b0frB0gr0egbKLiuzGFQuwaCPCOOnm8lylke1WEKuBq0qDjDY1masp2+tsG/cyRB
         Ku+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/apt+52sKgB53nCdY3/RVCRdbXo7s8enYyKffA8O8FLHftIGSTCdjs2b7JziFmBRhZ70I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPbT+r4/9YtrW2pVV2Twy6vr0r6KzVuV5ERk+71g3t4pV2TiIJ
	V7O7Z0bMJFrZKUVIE3NEZtBjJaq3KrtsO+VPd9L4R4mQQSAgn52Zb4tKuzzE9dQX9c2Cg9J4u3+
	IJycn4jql7nwOPlbxGcoHmOudhtN6/UwQ7bR0l8Q+S7fD7NfAN4FeJG0e
X-Gm-Gg: AeBDies3sf+ZCHzICB5BQZ9BxnvFiEHsCb6LcWdZxvj4UPVcgtc4RQyMDBvVeK8cWnz
	mOpOOOAY57rYFRKcfqWdwemRG+wKed+pZuDBZPpBHW+xxJSWc1DqXnCrvYbBv0i+cZmlLkDqWaJ
	Ib/DgSnsncZI4Jv4SVAanu0jcUfJggTkuZ1sw3G8xbmh1yVjTAQ9SfDrCYc/dOisV94iF8Rk1JB
	tE6bpeEq3mPxHmqZNm4TnalplDfEUJgsIwyHeqq30Q8mr0vU7RTq8Y/J1P26VK7r9efah5dbcUK
	IEmg8tNZ8jQO2AFo4oyjIJdyWXaR
X-Received: by 2002:a05:6402:902:b0:670:7177:94df with SMTP id
 4fb4d7f45d1cf-67440714a81mr166376a12.6.1776814482004; Tue, 21 Apr 2026
 16:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87mryxekxy.ffs@tglx> <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
 <87eck8daot.ffs@tglx> <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx> <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx> <aefIJR_FcEeP-fcS@google.com> <CABgObfaNaDYCo_rkkwAnFzKYYe9G9wnz1+yiv0H73CbtE8AXpw@mail.gmail.com>
 <87tst49bgt.ffs@tglx> <CABgObfb7Yy5Q3E2Boy_H4a0F3GodDOr1Z_Sw0BzdfvOmagcRnA@mail.gmail.com>
In-Reply-To: <CABgObfb7Yy5Q3E2Boy_H4a0F3GodDOr1Z_Sw0BzdfvOmagcRnA@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 21 Apr 2026 16:34:29 -0700
X-Gm-Features: AQROBzCRzODgAbweGQU1lrGWJQCiYZuwjSQcYcvoRHbZTHg1ImQh7JeiYCR1h_Y
Message-ID: <CALMp9eRyqC4bEqVL22x-F77fBbsBLv4HgTOyGfBOz_a=qk+Gog@mail.gmail.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Vishal L Verma <vishal.l.verma@intel.com>, kvm <kvm@vger.kernel.org>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	"the arch/x86 maintainers" <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 4:16=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> ...
> There were two different steps. Posted interrupt support on the CPU
> was introduced in Ivy Bridge. Posted interrupt support on the IOMMU in
> Broadwell (and added to KVM with commit efc644048ecd, "KVM: x86:
> Update IRTE for posted-interrupts", 2015-10-01). New virt features
> used to come on the "tock" instead of the "tick").

Nit: I believe posted interrupts were only introduced in the higher
end Ivy Town parts, but I could be wrong. :)
