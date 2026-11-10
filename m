Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335713;
	b=MlPkErave86IDfxQ+NVJk/GYNJm/Rf0uK4VyoCu7u0uzCIuvRvAx6Q9+rDQ8IFwGCy1l
	 0jQtN6mTSuCVR2OkYApt2nI0uXZQR2UYKom8bleelrpGtJOrwS4MgbicP1wJa9L0Kj+at
	 dtlmcfzIGoQSmHBy4K07/z7S2k0EqJ334q0JtHFuaDBA65+RbdstUfILoHnZKaIl9aC10
	 CBCwaSew5cGYXgWsmP7oaVWts4hLzNYYEU9Fyd4sE6WRM00ruozFZX1gddHJJMTTTXib0
	 Mj3ozP5bSN+0uZulnfpDc2StU2wYcCoMaVC/NqyAlhq+jRlycxtEEjSRNX6iLD6wz1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=dCp0Db26sWh4sAbqSPzWp1M0J6ydStL+IzHoLsVEdug=;
	b=nHAtDEIg7N8yGaOfsHHDq1D+d0pMaQjwyX0ZXQ9496+vkNAqWsKv3m2gq+G8yxGlLYIj
	 EK2f+vldDMyJTMW+jpUlcnPprNM3K9BWPUXKttaGZiAf+7yZsCe/Rkk78h5AZR9iylVfu
	 GKot5UpTmiAD4MVSN3llBDFVrEiJUbGHrZ4mcgAkwn0n3BtZGzb744BuLlF5MsN0k+skQ
	 qUtciXL7jOq3U44R8YyWEswK75PRUMVOFQMj3+aLY/Ap2a3oZuGGGGyNJwSLw7CZq1uKB
	 neTq4/s/Z1i+7ROmqDK18PwD7dAX9reADz5JCze7hhftoR8sVDNoc5y40fkOJ9lGolw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ctx22OId;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255C8606A325
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 18:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 255C8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ctx22OId
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso2482218a12.1
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 10:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794335711; x=1794940511; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dCp0Db26sWh4sAbqSPzWp1M0J6ydStL+IzHoLsVEdug=;
        b=ctx22OId3b1A89h+/g0DLFFIvF1rE/LJiVCOg314dN1i0WsgjGNLUdr9g5ogDUofXQ
         iTytv8eWhKYvvAc1PGv3tO469SZSEgiiM8pzHozoBPZ+JLjj4U60kg4GE7ooJgxxgMLD
         yYkNR/2PgzAqsrdBgcDkGmqae2glgyxhphW8A59/68tE1XL5f9uZe+BYr1Q+iDODYe5d
         DYjN8zKbWgC5M1atPcdss9TOVd98YuPqehqpzIzO8IOUKFSKplq5o47oSsn2tnQxaxmm
         uT0VRNaOVvoGtA5U6P1PyJMJR89m+mn5fyW1gkyhmmAlacc90Jj+otaDm3KCwrVsse/H
         ntQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335711; x=1794940511;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCp0Db26sWh4sAbqSPzWp1M0J6ydStL+IzHoLsVEdug=;
        b=O1M3uNjfIwk01fheBhYucQnQwm0mJZ7+Rfe73uSJGb2WH0aQC3unb07rOMtzV2gsOw
         z1S9mZdNuRpDOIr3yL2929X2GoVYYq0xPRNSY0Rz/DTqLwLqsIpCmBFDmUsbWEmw1ups
         z9L0aBAY4uISP2KLMLqDKvJMxYjpxeeJ7XRiI7iGb1a7YQq3lowIvnDdd35d78iz0M05
         rWH/e4dNb7f2LlKIk5KODey00nEp7s5iXazPAYJUYCuk/TkotHaGkHJgdevMzmQQAh9m
         z9nci5idafAiIghnfLN3Dc+HH2THstyAfQWaKDj0lcKat/U30jHlwZDyqKArheuYoktt
         3/kg==
X-Forwarded-Encrypted: i=1; AL+hErEoDGxRtF8sfO20on8Q4CAYAXFdtsRYJ+dNKLj9AB/XCxc11n7a0/L7fHOJEOWysCORW3g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gZO1FUCj4cMrvS33vujpGlacacVekbPbrTnY9cTNP2wa+RnnK
	TtsQb2mSJxjD30grs+O78aIFOWPEZu5UpO87T/pJeoTo3jTl93a9aUWnetOO95KDSu2jlUBkpB2
	P0kt22A==
X-Received: from pgbbo3.prod.google.com ([2002:a05:6a02:383:b0:cd8:ba74:813f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7907:b0:3e1:bcb:1d19
 with SMTP id adf61e73a8af0-3f1901885e4mr3216153637.67.1794335711215; Tue, 10
 Nov 2026 10:35:11 -0800 (PST)
Date: Tue, 10 Nov 2026 10:35:10 -0800
In-Reply-To: <CA+EHjTz-Nb-g9YQKX2fKk61hC2BfzXfmUHv=2j+eZ18YuTv2Eg@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110110724.3614412-1-fuad.tabba@linux.dev>
 <20261110110724.3614412-2-fuad.tabba@linux.dev> <avM81YcTBTJ8zCMX@seanjc-mac.roam.internal>
 <CA+EHjTz-Nb-g9YQKX2fKk61hC2BfzXfmUHv=2j+eZ18YuTv2Eg@mail.gmail.com>
Message-ID: <avNj3kdnvQiY_ity@seanjc-mac.roam.internal>
Subject: Re: [PATCH 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's dirty
 ring is full
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 10, 2026, Fuad Tabba wrote:
> Hi Sean,
> 
> On Tue, 10 Nov 2026 15:48:37 +0000, Sean Christopherson
> <seanjc@google.com> wrote:
> > On Tue, Nov 10, 2026, Fuad Tabba wrote:
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> [...]
> > > @@ -4461,6 +4461,12 @@ static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
> > >                          break;
> > >                  }
> > >
> > > +                /* Like KVM_RUN: only the iteration crossing the soft limit uses the reserve. */
> >
> > Please don't include AI comments verbatim.
> 
> The series is LLM-assisted, but the comment was actually me.

LOL, I think all of us are getting a bit corrupted.  :-)
