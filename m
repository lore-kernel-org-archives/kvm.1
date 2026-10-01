Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ADD361945
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 21:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790890456; cv=none; b=SELl0FvOaPRf5iKBBi5aFK+RLfkTAh7WZ+Nmf+b2z4GfU064G8+jir5sQ00Pcfjl55jmae0U/5S4ohYZ82yovX8rm6CLXBx+iYJmRvEgf6GPWQXn16k8byi/adA0oJblnyKue0VhuffYcpMCLH4Z4RG24QxOlrpFng5zLTSZp2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790890456; c=relaxed/simple;
	bh=bZc4ogm5/WT7GTGjXs62z4TP6S2W3GOrNVtANWpbLNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bM7E6KE1agjDeDbWEXsRDJadBMSgqlQRxluFc8+jvuVmUBdOTUAblcYerWzyLBduOQCowbkMQOWcE+dGhxneBdzlApzYfJ3+8YQprIVBbuP+5/DnotVuvzKQgm6umRt3vDSjSDqiX738On12pcOvgNAeZtvCkQS7k+FgeXkDMvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RLtpeniF; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RLtpeniF"
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-80139a2495aso11581660a34.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 14:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790890451; x=1791495251; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZc4ogm5/WT7GTGjXs62z4TP6S2W3GOrNVtANWpbLNc=;
        b=RLtpeniFz3bw5kYbdZcN8sXZlLxXUm8eueWT/PQe5AIXrU5FkOrBH4vN/xuH8ju2/w
         bKev0WSEvHGl5WoY21NfxsnLU0/optlXXH27lTMnMPIvzpMzwSI+oELJJN9JxW1+XMqj
         5XaGU1q3IUAW4pBIfZ8Dnu/1dEaJcWrVRuyIKtqOpWfm4+SRTFJbbtgalbhfuuPufo3A
         2zTlITVxHT11MB4k3Axk6xUf3JY3NcROZdK6JAIe7KL1kk+5vd+PFe1gD8ac8nhtAvyO
         brMjwJC9GOh7sM1xtzG3GQy2rQW+PdVBezfsPHIkFTSMzF4g0587bxmLCCzG7YGxNRPc
         NAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790890451; x=1791495251;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bZc4ogm5/WT7GTGjXs62z4TP6S2W3GOrNVtANWpbLNc=;
        b=dFrvcCnXHxDfbutJSe2/RKmCV86Y7MylTTfQwupLQLTu5RlJIaLoGf1nuVfP3fq/y2
         4iWxqTz/URGxtZ3VRg26FykQMnoZ29f5qOqHI/hdINkanKg5Bgl+3xDtu49yeh8aPHJ4
         50zkH8Ex/5V+k+mNxifj3NAvYCpk3hCWLIvdr440VBVIaN+oVlusH85v0PgMp9nTzWqI
         y3tXlfud8FUny7yeIOryvp/DEkBP5e6FLOjsqwzjYU/9frpIqQL2kCQ7cYTzvfZuclJ7
         mLiMi4ZxU800dw/eQG/d1IRqn6I5/ou/BpcodTOGM9m6vPrbI5f3ovYVZy8rmAqMD1Dv
         Uypg==
X-Forwarded-Encrypted: i=1; AKwUvBw32E5MM2b+z2xXjncP7jHBgJLOSL4S6Ox+BLlvIAtLBvG5UTlKwKgtJhh9sa9XSOiZQhY=@vger.kernel.org
X-Gm-Message-State: AFuF++kBKwMxB3rU7/MlfxfDCKXKLNJUZy/lNP//Rk2nsWcWUhLTUEX7
	pEZnnVvTVAOxahSero477NSQLPZs3ImSy7ByFuoKyRD5vcSuQt73RhqwljSGM4EFxchlPxjCnSy
	VZ+Gen2VKvbqrEt50y/NvtltgrA==
X-Received: from iou20.prod.google.com ([2002:a05:6602:64d4:b0:9c7:5697:9ad7])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1583:b0:4c5:12a4:ec8a with SMTP id 5614622812f47-4f52aa86098mr422937b6e.36.1790890450368;
 Thu, 01 Oct 2026 14:34:10 -0700 (PDT)
Date: Thu,  1 Oct 2026 21:34:09 +0000
In-Reply-To: <CAFEAcA9DYo3GW_59eZjsk1qL0--3amYd7ufPqt80O2qv=Qm_pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
 <20260924173051.2117637-1-coltonlewis@google.com> <CAFEAcA9Rwrffx8bYiOxrtQGdg31QAz1oBm8okzpfqHZ6yK0Y7A@mail.gmail.com>
 <20260929212102.3659389-1-coltonlewis@google.com> <CAFEAcA9DYo3GW_59eZjsk1qL0--3amYd7ufPqt80O2qv=Qm_pw@mail.gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001213409.2090008-1-coltonlewis@google.com>
Subject: Re: [PATCH] target/arm: Enable KVM PMU partitioning and counter limit
From: Colton Lewis <coltonlewis@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Colton Lewis <coltonlewis@google.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
	kvmarm@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mingwei Zhang <mizhang@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Peter,

On Wed, Sep 30, 2026 at 12:35:02PM +0100, Peter Maydell wrote:
> On Tue, 29 Sept 2026 at 22:21, Colton Lewis <coltonlewis@google.com> wrote:
> > For the counter limit property, would you prefer that it also live in
> > kvm_arm_add_vcpu_properties() as "kvm-pmu-num-counters" (KVM-only), or
> > keep "pmu-num-counters" general so TCG can also use it to override
> > PMCR_EL0.N in reset_pmcr_el0?
>
> If it can reasonably easily be implemented (or potentially implemented)
> for TCG, then I guess the general name makes most sense.

Sounds good. I will keep "pmu-num-counters" general (and wire it up to
override PMCR_EL0.N for TCG as well) and move the partitioning toggle
into kvm_arm_add_vcpu_properties() as "kvm-pmu-partition" in RFC v2.

Thanks,
Colton
