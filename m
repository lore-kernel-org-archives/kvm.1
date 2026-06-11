Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FEF1BD9C9
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193362; cv=none; b=ozc4cRx4GW3/mSj+qVIt/vCLQ+mtHUfdrIDnx/EGsPtymsYbwiswUWcMH74KAkyFqaP0O3GKA6ukWyVCpn0djvT9Jl4BEoY9BK7mYFG1PkPtDpkgDbOEIJeTtqjCRD7y6v1NaV5fR1GxnxgrQ4+vWQA20PgWGdneRYiMNZdRy6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193362; c=relaxed/simple;
	bh=DkzbHjRhWyLIhZObZzEQ6rv+ZmkhQxYL+azMEAjGxFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MkDvy3OjQmTCwGpY3kIJww0dM0tJe/aExzRfApquMBMlwgeCzvozWo35CqK4YyxApQMxUJsQYrMMHZbZEYq4jX8x4pgaEadrGsOtW/l/u7bmZbjleInd02/Qt++ZiP5pTYHFEvOMfz9Jj1+4hwdGz8dAKi1lw0I+rab77WX2zTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K9nwwkLr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9nwwkLr"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf1dece2ecso81900705ad.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 08:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781193359; x=1781798159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+njslxGsjU9ovOWXP51cNMoTFVtjJDKCZoq+4hEp5pI=;
        b=K9nwwkLrRXFYN6qRvZcnjtPM8OinGoQaYYO6lSVxTh7RQ6jTt4N68BAlkQtnG/4BUd
         fKvvrqcRob8BIcENZ00mgKG31ZIi2RzRRtdegmIBLETc53hJNL68agr6yy9gEyIyPeuo
         O17DlQKqpu9yPgbtGpmLZIhnUb0yhF4sJc5fLs760Kx6VPyti9HP4t/9yRyWzav/kH4j
         /sDWOQqW4eQsrJ82avaACHTSE7TPaYGknRzDmEapZ65gAAinRG/KuzqMRaEZ6BMDPYth
         PgswiNJm74Odo9O81x+hBaViHXpn4p9w2Wa2KMjgjv/hUx4bYb2wuAZvRRsukUMMbfYD
         R7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781193359; x=1781798159;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+njslxGsjU9ovOWXP51cNMoTFVtjJDKCZoq+4hEp5pI=;
        b=lJfu2EhaAvxUhYUL2yXcNU6HAPAc08Rw5YgzTLKxoII0fqz73PQdQF2062I/YCy5tx
         Kb8eMkt0c5iXi9lhyyDRGQTTHs+7VfYucoJo28uJgtNhgqnUiFwhn2Fa5MlHK6xFV4p+
         6zcRG8wGGvnSTwUEPfSPQPWsCH/kWU3tAe8l9RQgvi7emX0H0Sl2XnnlVGo+0JhX3LvR
         X8fSMRwd932bHifbGaNRySliSjwDrdW0dGytbMztG+dfs0U3vPB61W8fhWzipGsv2qBU
         hSq+H4RTd42mEFpRp/O5HCqs+VDHRLvDvZreNgzR05hmpF4dB1Q0eNkVBbVr8A1QkZOy
         +Q8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8qhvdkATHcly5kyj4wDv6mJZh/cO+5eIafsf5EIu0cSpJEnsiXNa2TnCEAAQyq7IrAu4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwYVOaOWvZ+5CgwQy6dbu/tGr1qf0PEMDNoyuUTFugR/16Fomo
	Ja3FRFrxorljnXhI5z7ElpOfwmgHBdUOoCGWVRWi1CVjmZjyC+x9M13sMJ8vYaazQuiID5kMWZ9
	57mYXng==
X-Received: from plbmc11.prod.google.com ([2002:a17:903:2b0b:b0:2bf:32d1:a319])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f550:b0:2c0:dd75:e824
 with SMTP id d9443c01a7336-2c2f044033fmr38411955ad.4.1781193358972; Thu, 11
 Jun 2026 08:55:58 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:55:58 -0700
In-Reply-To: <7428996952122d5943715c8682c6ad1c353566f9.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260102142429.896101-1-griffoul@gmail.com> <20260102142429.896101-3-griffoul@gmail.com>
 <7428996952122d5943715c8682c6ad1c353566f9.camel@infradead.org>
Message-ID: <airajin7CpO8HoSF@google.com>
Subject: Re: [PATCH v4 02/10] KVM: pfncache: Restore guest-uses-pfn support
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Fred Griffoul <griffoul@gmail.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	vkuznets@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Fred Griffoul <fgriffo@amazon.co.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2026, David Woodhouse wrote:
> On Fri, 2026-01-02 at 14:24 +0000, Fred Griffoul wrote:
> >=20
> > @@ -55,6 +70,27 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *k=
vm, unsigned long start,
> > =C2=A0		read_unlock_irq(&gpc->lock);
> > =C2=A0	}
> > =C2=A0	spin_unlock(&kvm->gpc_lock);
> > +
> > +	if (evict_vcpus) {
> > +		/*
> > +		 * KVM needs to ensure the vCPU is fully out of guest context
> > +		 * before allowing the invalidation to continue.
> > +		 */
> > +		unsigned int req =3D KVM_REQ_OUTSIDE_GUEST_MODE;
> > +		bool called;
> > +
> > +		/*
> > +		 * If the OOM reaper is active, then all vCPUs should have
> > +		 * been stopped already, so perform the request without
> > +		 * KVM_REQUEST_WAIT and be sad if any needed to be IPI'd.
> > +		 */
>=20
> I am unconvinced of the veracity of that claim. We get here via
> __oom_reap_task_mm() which has explicit comments about 'might start
> racing with the dying task'.
>=20
> I think it's actually fine to use KVM_REQUEST_WAIT in theory...

Actually, it has to be "fine", because KVM already does KVM_REQUEST_WAIT fo=
r
literally every releavnt OOM kill thanks to the kvm_flush_remote_tlbs() in
kvm_mmu_notifier_invalidate_range_start() -> kvm_handle_hva_range().  So I =
would
say don't worry about KVM_REQUEST_WAIT here; if we need to fix anything for=
 the
OOM case, then we need a more generic fix.
