Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F146048CD49
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730071; cv=none; b=twmh6dB+1lUthzJTe4IafhvJtx2t3aAxoLhvyuq2A+2g0BtMp0EB1BbpSDtXLJclCuHc3K0kz9E2e/5oZPruQheOi0Za6CGsRH89q4kjoIQ9fmxgkn0cNyXf9lI+Tph7ZV7s1Yv99OC0gC5jm0hncvKZwBp5nsJfNHHl9bgo4wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730071; c=relaxed/simple;
	bh=kelXrAUcmR16AHMfbeqzvm4QWGruE71feFU2T56l/6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qHecwIjbYaXwuRShuHcA3mlgkTgpD9s7z9F9oFLcn0ZEawfc/6qYkQ4u7lncSaufSIuN12/zc1SlgnjSIXG24aBE6EFHHIAxY4rxiw0zZ4ycIMM0tcBv0A4RMLy5wjM2ObUc2S4BLuPhuR9V9InHX92EWJCIZr1ldhwL0eE8XvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qexz1XQ+; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qexz1XQ+"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84fa3b14ed2so1061356b3a.1
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 10:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786730069; x=1787334869; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LfaLWAErtycI8626dIr9iK18/ZV1rhd51zLN5VGW8CI=;
        b=Qexz1XQ+slZ6ld3fspgg1E/aN4T4ZY4CwqipBXDAvhfvesG8tjntKX6CNJ4DNIj+KL
         eX4EHXNDE1a90cLjw2L92esxUy4WWuTns6SZvBjAjfdfYlSgknJJ/mdiAoMZnP0R42zw
         /UMjWGw/YI1TxXZt6E0QMvu15t7ryPmdR0H+WG6mZRiVias89c3UaFUDNR48TWyraQKB
         XzHLre0rOLs1CibrFNc3OzmotwQsOmoiFNc/eax8iRaKNjs9KewqDLK9fU2wMOxi3YFt
         ZlsKFoDpBlggEqcNpRnkPQA4aKrwVP2XREDdlN0gN0/9U45B/g6jfipLMDMd2StVOLse
         rhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786730069; x=1787334869;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LfaLWAErtycI8626dIr9iK18/ZV1rhd51zLN5VGW8CI=;
        b=M9mehKNsjghJ/YzYftiK2j6jlRVn5m6bzsXvDdxexZ6bR3qN6Ra7n2Ad2o4m/UK/8H
         SfIKVtodIlS415wRcoCLR+zJ436YR7RExG+aulw0Yv8R27N3jg/dIuZeLWMvjw3OW0Ia
         R78yeyH6viNPiGzglJG2FitZ4S//ibVc5oKojsk4xHvoSs3qwVnPOfVvcz4DnPkbECRs
         lrb5/xkceZE9y+F7Xw5Fp3re3GwlTgePJSN850znYErAGgEgNti6xpZC1jK5wv/XTF6R
         j+VfYvUnZ7Ot1s6WdsUwe1VRqVMIE1dLRVHCkym3K2XFbd/T73S2mEcBswhY/uOkSL3B
         cXUQ==
X-Forwarded-Encrypted: i=1; AHgh+RqVYmWLRQbhO2ZL1uE/4Cd90cZJvYR65vYb0Dn4bu7doWR+d8z+6JgavkB0nqt5qmhhQ1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeAfFdOxbZHncJEtB3cc+nDQdzAqTj6FmxYcl4Z6G4GJqBgasw
	x564WdvgGB2Y8FdJlTB8yJzG8pyhwnAnLdPku6Ru+NspZ4bAbovJD4Sd7miFGSsCi2CwMAreFzp
	JNbuC7Q==
X-Received: from pge22.prod.google.com ([2002:a05:6a02:2d16:b0:cbe:e919:f4bc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88c3:0:b0:848:4d1a:9554
 with SMTP id d2e1a72fcca58-84fde32cb70mr7530427b3a.38.1786730069038; Fri, 14
 Aug 2026 10:54:29 -0700 (PDT)
Date: Fri, 14 Aug 2026 10:54:28 -0700
In-Reply-To: <c5c532e01309c8c73de2b0f393539b608c495f1f.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <antQYJvRxJxOjtut@google.com> <f5dc701cf3319a7b3c8fd1497f26d051aa9fa3ba.camel@infradead.org>
 <antb01WqOrs-tztm@google.com> <6ab49538675d97f1f4bf01574b1b066aae0bc05c.camel@infradead.org>
 <ants4VjfAiblaWsl@google.com> <3dc73f745b6abfd1eb53e7d3fce2067eaa3b3c92.camel@infradead.org>
 <anuYNxD81OE3MrQw@google.com> <5efe7a3914a3610ee00a487379caff84af6aa731.camel@infradead.org>
 <anusv0DloFhLMMoW@google.com> <c5c532e01309c8c73de2b0f393539b608c495f1f.camel@infradead.org>
Message-ID: <an9WVBHSsy5W0PUk@google.com>
Subject: Re: [PATCH v7 17/36] KVM: x86: Allow KVM master clock mode when TSCs
 are offset from each other
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 14, 2026, David Woodhouse wrote:
> On Tue, 2026-08-11 at 16:14 -0700, Sean Christopherson wrote
> > I'm not totally opposed to a broader GET, but we should definitely get Paolo's
> > eyes on this sooner than later.
> 
> We've been saying that for two years. Shall I bring a net and a whip to
> KVM Forum? Or Plumbers? :)

I pointed at this thread in the "clocks" pull request, so then should be now,
soon.  And if that doesn't work, I'll just rename the getter to
KVM_GET_PAOLO_PAOLO_PAOLO and send a pull request.  Either that will get his
attention, or we'll have a source of amusement for years to come :-)

Joking aside, this would be a good PUCK topic if we need/want a synchronous
session to sort things out.

[*] https://lore.kernel.org/all/20260812213206.1564354-2-seanjc@google.com
