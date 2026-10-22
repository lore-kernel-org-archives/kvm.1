Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709067;
	b=ovzV0hYcev0BUsaLQCyiofrmLgYZjP6icDlNASrNbeTFv2sXy6vMr3BYoSfi/FUWPm6R
	 IHaL0lbf4QKZ9sK4mZ+FSEaydGWNoV3tnqYz79At9GYa7lh+ZpclEx5evjrrRI23dUl2C
	 t7IRtpTUsEO8My8zCr38buHkG5sOq9PG/SuHzSLepWJxla4JxuUv0hKsZOInTk2O5SPA1
	 NhSh//aSqt6bPjBvdSvlqhEnm/nKUzRKsszN5ncfiHNs5crO8oHs7Rl63yTk8Ky57UUN9
	 gdbi+TP84KW+tzRCxaU+KxldMmPrQt0V9SHZgFjouh5zALhte3AQElaoPV6NV+296uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=5J9MvBdhUxYTb7Mgm25rcoiZhjWHj9jpVpCDuA1tNH0=;
	b=voWXb5uk6P9YW/rt4mN/6Fy2loHcowgIun+DGPKglMYqHiYF60YW61weCBDlb3ED+veo
	 GMFlSEVgQpxB9ymJJ7nzbLw/iwkV123OuE8TvPPfvEN7vBqKga9INsMMDNr2dgT08tpPb
	 /Oe6Q716CYth8a4OwsiMl1g1tOQEWLxxh8AlzL5iniWR3YhpcdAIAwdzVCozni8I6e25x
	 phYZ+ORX8yW0zrfevarnPnbvbuq14Rai9jYo0xGOFM7osAXkbRBwPz53+l4bye885m4/0
	 0oxvWZ49Mb1qSnUJ6KI9udFj4cjv5ofv27Zh1J+s8YFdMXKX33wTASbct8UmhouIyjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=b+u+BYi2;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A78606A31A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 22:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60A78606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=b+u+BYi2
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a0688a43d3so240114b3a.0
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 15:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792709066; x=1793313866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5J9MvBdhUxYTb7Mgm25rcoiZhjWHj9jpVpCDuA1tNH0=;
        b=b+u+BYi22ZGcvHTZlTlhNryGqKw7kEoV8iSsZOa6UHZ7wOI/fzxgxGD+NQu+F/YqI5
         mK2r5MOV3hBego+D3ggYIuJxfd+c7uC0DQ4LnzQ3tEtdSPfzU4W5FN7jna0le5mUG5cX
         BdQCpa8zruIgFNGc76kNYZSzbjGfx8m9yuHsndJdMHrbfem6aa/ixxE8Snz3qtxw+6bn
         l6eBuV71A0i2PI6HmtRRLIuaOboJF2dNGmf/jibfiO6w8wJpCx7CibaC9xltmcs4AqkB
         O8zfki8be0/EZDmv8kbX8jtNy/ua3QUR3zQDhYefomm3tLXzD0DED/I7xMJ6WgMWbyIj
         SssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792709066; x=1793313866;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5J9MvBdhUxYTb7Mgm25rcoiZhjWHj9jpVpCDuA1tNH0=;
        b=gezz/Tnokb+ka6zCJqC+NV1zWl0KkSw72HgvxgzA5vaQRsYg8PNNp1KXrs3N/QDoSP
         T0R1D2FijQKWpMi8gW4QSPctps41o1tiITaoBk+OJUDnzWuKUBxROzp+KSejMKTJGHxA
         lkj1rMQ6ix49Bo1mB10uMtCjvfEj0+mcZi4OE2YvK+RXPznkdE8IgFZIS05nYxYG4w1e
         8sX6lYN3/zliuLhJYjUTj9cjvxNvSWkbLDL0uc5MnZRShnzY6q0TvV2G5p4Z6WDOQmbz
         B4VQIhBzJRPPiVsLpiyYYnDoLonyVKFKYEO7yE6wtBxV9iSx7qSUbClkVzCPcSSCxVJp
         OPYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwezJrMRfdmnNDB5JeWNO8/iF9aW5nq0xpSGiQ/TzX18XUXi8s2IvukWlndRUidCGPjwQE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2Vz0M+K8XuYoYvSt0qJr4TY8UmpmEfGPi57HWzTosL1w+X4Q9
	YJ293SWmju02AWwCCNMEUcuLGrEO1lSRTNqPi3pYTCsmwl58EjH/jZGCLw2jeavTlAcOt9U43Jb
	9CXHM+g==
X-Received: from pffk13.prod.google.com ([2002:aa7:88cd:0:b0:886:fe91:dda4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a0c:b0:886:458a:42e9
 with SMTP id d2e1a72fcca58-8a2c767402dmr349482b3a.49.1792709066272; Thu, 22
 Oct 2026 15:44:26 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:44:25 -0700
In-Reply-To: <CALMp9eS8KDozNGT9J_uN69W32QEvTbg2JrtRqN0ESi00b_uq=A@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-27-yosry@kernel.org>
 <CALMp9eS8KDozNGT9J_uN69W32QEvTbg2JrtRqN0ESi00b_uq=A@mail.gmail.com>
Message-ID: <atqRyeqSXViiNIk6@google.com>
Subject: Re: [PATCH v3 26/27] KVM: nSVM: Use different ASIDs for L1 and L2
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026, Jim Mattson wrote:
> On Mon, Oct 12, 2026 at 4:37=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> Moreover, does this change the semantics of PV TLB flush? In
> record_steal_time(), we have:
>=20
> if (st_preempted & KVM_VCPU_FLUSH_TLB)
>         kvm_vcpu_flush_tlb_guest(vcpu);
>=20
> IIUC, an idle vCPU that wakes into L2 will flush only L2's ASID. In
> the past, with a shared ASID, L1's ASID was always flushed on emulated
> VM-exit anyway. Now, L1's ASID will be unaffected. Though I can't find
> any real documentation on PV TLB flush, it *seems* like the remote
> vCPU would want L1's ASID to be flushed. OTOH, this change makes nSVM
> behave just like nVMX.

That's a bug that absolutely needs to be fixed, probably relatively urgentl=
y.  We
should also document that passing through the steal_time shared information=
 to L2
to utilize PV TLB flushes for L2 is explicitly not supported.

I hate to re-introduce deferred actions for L2 =3D> L1 things, but that see=
ms like
the only sane way to handle this, because handling the !tdp_enabled case, w=
here
KVM needs to sync the current root, requires knowing what MMU is going to b=
e in
use when L1 regains control.  Yuck.
