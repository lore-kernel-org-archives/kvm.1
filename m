Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A4754EECE
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084206; cv=none; b=L7NkW2DT4VOcIAujf33HDa+SGH1q4Jj2W7o0uQfFhw1ufpX40FzT236LJKQDZ0+iKeuhLuYjHVHJm+RHQerJIEeZP8XXWCNiYxvhL81fvWzZPknRcDEIlvIxWXucuvZNpayAXqw2qCU96eyOyH9TKE6yyzHorcY/wDaS18x9few=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084206; c=relaxed/simple;
	bh=d/S9qDtUy11NQeQug4viOvCaczHDmqizyhmmIqmbdss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gzW/lB/u+Yr1mbnOSyVU3gmsoKIdGlCs9HIF9Co63118cE7c1nO46jYtPz1N+hR610fRC3f3rEZpjv7OpoJZOxjY14P0x9gUiK8obgaBPn6OXY6jkRN8jIcPjLwkVEfeddFCz3zb2V63kXRgbILPCrjgQ9RMAN6KKxifog/LKoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qr6pOFDq; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qr6pOFDq"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfc52ddc55so55715145ad.3
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 06:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790084204; x=1790689004; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oKg5F9sMGobIhjbifmhiyQNB+ur0ve2Pzm+PBviIzFQ=;
        b=qr6pOFDq4OlYrcoQ8bziwCoxi/tXVKzym1FX3mvkJtpmCIiN+shc9iOgRor5IPuYkv
         iDlDT7hOEO0rpJxaP2qTYhixlBl3mGrCjV4OmrO7EHpmAdZbqbOY8qfqrzBm8osZJ9k7
         CPyF8L+koJKFT3Ym3vcufuJSR/oujkTKFM0fLpwkRA3zeWy29amjsH/zL+Y5Hhv8YA1X
         qrJzM17lwKdKiQw9yVJCLJSOh+JBD8A/hxWMh6qDeaeX/RRV6gHpepA5rAlHLqkx7ied
         zCh8Y0b2Yab4eB9Fx+opGhK2rSkNjmsFVYaj4UTXQftmCs0YHesneZoiA8ew+oTpoAW4
         8BNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790084204; x=1790689004;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oKg5F9sMGobIhjbifmhiyQNB+ur0ve2Pzm+PBviIzFQ=;
        b=bzlj4WZEn9c/bVtsLc1mclEBmFOq+gvZzSV+c59TepHXZX+IbfbVgXPqcn09vtMek6
         nF5YIDY7NXFZKKbn7XKbK+fQi92aZfarUJvWqUqDoNRIapUqcfNmRRhzXCV5XBcQXlFo
         S0Q4gCxoVSWiQ5cyTLZ6ua4YgcfCxbr4K9noigH7qdkeowbkqqOiv5tek9+uvh3xtPmO
         M3xaF048G0tMdOUEQCF7W65JbhEtWoVdCKo+5LeARlCyhJi+vmIVs0rVsRVmnjs2ptsm
         xGfeSS3WS+L5vgwwiz6m8785vH+FxGr+xHA0naLOvFZAd+wJ6mpwcZBKCDVI6XMKibCu
         0Stg==
X-Forwarded-Encrypted: i=1; AKwUvBwbkuJhdNwc5D9h2lU90Dqtt1nTiou/bK5a9HD7PU5fBf4IRX2tGeGK2P1lLMhuILYkJAM=@vger.kernel.org
X-Gm-Message-State: AFuF++kdIC293uP2okBBI11xOVVUkiyO/WL5TAPeY0GU5vP49uqi7iHz
	8rt+8QZ6rN/vgpuYd3pXhZHROO164jWMdCfx4KKQUkjI/tOegloH3UjwyxUBm+BNcPO5wr0lotk
	rZTiH0g==
X-Received: from plop21.prod.google.com ([2002:a17:902:8a95:b0:2df:47c8:8ff])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f0e:b0:2dd:c1a0:c7e0
 with SMTP id d9443c01a7336-2df609d446fmr13805055ad.15.1790084204032; Tue, 22
 Sep 2026 06:36:44 -0700 (PDT)
Date: Tue, 22 Sep 2026 06:36:42 -0700
In-Reply-To: <ae797ef1-4742-4957-9e28-cb1b87b1ace2@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922000152.1113202-1-seanjc@google.com> <ae797ef1-4742-4957-9e28-cb1b87b1ace2@intel.com>
Message-ID: <arKEamenf6X4L9w7@google.com>
Subject: Re: [PATCH] KVM: VMX: Move bus lock handler from main.c => common.h
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 22, 2026, Xiaoyao Li wrote:
> On 9/22/2026 8:01 AM, Sean Christopherson wrote:
> > Move the bus lock VM-Exit handler, which is basically a one-liner, from
> > main.c to vmx.h now that to_vt() is usable in common.h.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> > 
> > This applies on top of kvm-x86/next + Xiayao's series.  I.e. actually applying
> > it will be painful for anyone but me at this point, but I'm really just posting
> > for posterity.
> 
> It seems like squashing it into patch 7 of my series would be OK as well. I
> guess you intended to avoid changing my series since it might require a new
> version.

Heh, I would have happily squashed, and tried to.  The problem is that I want to
land your series before "Move common VT getters/converters to common.h".

https://lore.kernel.org/all/20260904010353.3175819-8-seanjc@google.com
