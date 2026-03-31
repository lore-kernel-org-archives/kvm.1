Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5F9317715
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978470; cv=none; b=scxXO/Y195AsqPde0+h2ReN10fsb3mpaj2yXS/DihEgsFehG3TMESvcyszVmrCOzg5fL6wlMrzZ6ULFknbdnPCes4x3G0kfmdLI+ac70DCyRh9AWkSARqrLjV/4U57M+JYeemt4cD8OBJGCBsqeg8Twn3cdquifAdUxnRKclF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978470; c=relaxed/simple;
	bh=qCv4c4THJXSx7AF6e43ZJQq2LzLgFbcozK25xpwtu98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QP9T96CW0DPCpncxdbIOrazm4l+Mm1fqvmmAIqOWUTKc5au7NYlW7gFci1SMZ/5uMTj6LV5lM0+UDhUEjyd6qQ/aurzAMerpk/mqAXFk4rYYNqs2TH5ADWDYXqMTn+Ueq5H7a+JvyP1GacsmrjWDGMJFcb0HOd5gL5kotCzVdjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTuIQw1S; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTuIQw1S"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76ab2f392fso883986a12.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774978468; x=1775583268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uC59hxE3azimspCxDO1hAb2b+xX7v6aaFqxxO1CSRNg=;
        b=RTuIQw1S/HXn93X1RCBP9xxMq7+R4ikZFQXgH4Z0tQ2EVnjpQ79LjxXSinYpNfPdAd
         0ldp4S87Ol2NrwFEBbXkW8XMOOPZRGdRw/kGS4c4VSKLbJ06TU8NTLnPY2kCOQYBO5TP
         R+m7pUVrcqbC4UOD3vFczHuRDfDr3w3S9DOhRHJzRPFlkGtPrrEm2F15e7alKVahVTZp
         g9oXAeYJhFZE7gKPYaX9Mj2nf+KHprOflj1FoFhjQp3MoMAyp/Y78HmKPQFEI5Ut7fvi
         HDycV2epcGT8c2Zki/KTBT7AmxVsFP86TfqRLtfUWJJmgqYO28WS+OE87UMtEscjoC3H
         7crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774978468; x=1775583268;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uC59hxE3azimspCxDO1hAb2b+xX7v6aaFqxxO1CSRNg=;
        b=IdrCnR8Owkv0+A0JjNjM/+xD5s9xnV2SzrkjjqxwQLRvp1CbeQdd8GR26N4v6ZgT3E
         SJk+DdNOwrM8q94tDlGlejnjfEkAxdmzlDWMfteRuLshbvyuw3Ko6opAVr4OfoWPpWhy
         Ggtyxx3d2P9aQehnhFouYzBiZFjILLw7kVUxp0gpCWuzUNOzOX4enbBCNxwWsrFcLilX
         r3dDZ86Md15AXk/wPsWwWY3AZ/dKF7u5Dy9Tx8vFpi6XgCwgbVnDd0gkEqnriKVAdyF7
         TZOwv/jhHuAOV4p4pgJ3VFT9sS57JRKwDZBY3qJT3Am0BQcJ/6yQf688RFFmeo8wbemF
         e+Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWNTc08ieMTqTyJyT0Y048bjCbOuuy86RR+PBLqa8iSmSPNBnAF8MNwr8Ps6+bcgvfm1OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAHL6TZP3yuElSo06G0Z2jAAmowfLAi9d35jn8+XMw2CtO3pMu
	YeYEJ+s/xybI7ZRl2+VaXQORf+DErpsDknSHp8kGyQ28/Gs2dwZ6PBp8CFv76UTRX1z8m19gm4I
	lSrNJPA==
X-Received: from pfgu10.prod.google.com ([2002:a05:6a00:98a:b0:82a:6dcf:c1fe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:23c6:b0:82c:daa4:ce30
 with SMTP id d2e1a72fcca58-82ce8ac8e2fmr396477b3a.30.1774978468361; Tue, 31
 Mar 2026 10:34:28 -0700 (PDT)
Date: Tue, 31 Mar 2026 10:34:26 -0700
In-Reply-To: <20260324124002.7670-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260324124002.7670-1-manali.shukla@amd.com>
Message-ID: <acwFolDAoqlY2ok8@google.com>
Subject: Re: [RFC PATCH v1] x86/split_lock: Provide KVM helper to log guest
 bus lock exits
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: pbonzini@redhat.com, mingo@redhat.com, bp@alien8.de, kvm@vger.kernel.org, 
	x86@kernel.org, nikunj.dadhania@amd.com, Naveen.Rao@amd.com, 
	ravi.bangoria@amd.com, peterz@infradead.org, dave.hansen@linux.intel.com, 
	tglx@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026, Manali Shukla wrote:
> The intent is purely observational =E2=80=94 give hypervisor owners
> visibility into which guest is generating bus locks so they can act
> accordingly. No policy enforcement is done in the kernel. Suggestions
> on the approach are welcome.

This makes no sense.  KVM is exiting to userspace, the hypervisor owner doe=
sn't
need to grep dmesg to understand *exactly* what vCPU is generating bus lock=
s.
