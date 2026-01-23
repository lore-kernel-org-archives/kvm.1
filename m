Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4161257845
	for <kvm@vger.kernel.org>; Fri, 23 Jan 2026 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188669; cv=none; b=RSG3oRw0urGWE9ef/iCz8oQ2bZDA2juBHTo/Fk+DnifqD8MHwusNf8+ou3T7pIf6xrveuvHD2HFA002TLmYMCJCWLWSS9HgTuL0x4zUDfOqx421jZbbtGKb3Hi2OEu0+fnAr6wyPw1dqee0SocIeZDZ3IHfMDc4GChLqFD4ckTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188669; c=relaxed/simple;
	bh=XEuKYMU3yOchzREZZdYCxQAN/c1AbT8tVJqvZScqUq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SItoPiRMXP/4biLc3Pwptm/HfOJF/cY6/EQh10q12NZ2uTEoM330iD3Dh2klHfMl5D20EiloqbYLpBBkI5B0Q1eYhKw1/fx2cVJ/SpuYFZtUkV7EzQ4/At/F6a7llkKZ76xQdjnV/iZFjyOIostG55vsfK3wUDij74+VzVYNFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SK/cjdCO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SK/cjdCO"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a7701b6353so24348265ad.3
        for <kvm@vger.kernel.org>; Fri, 23 Jan 2026 09:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769188667; x=1769793467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x45fhEbj3h0C2LSTj+jCNFve88XybM2CA/P7gFjNDUI=;
        b=SK/cjdCOyyLIee73jTcH+gvG0mrIoDc4CqOh9NLTYX/dU+dVqzvAMxKYstBQ43pEL/
         tKnP/JUjmO/9Bgok8sJkm1Y1euTS9ms0i5cSUa5xfGb2sxk/fJ804SkLEAONl632HsSZ
         86Z4+9QoJdRYQHAKvlTglrEiFDYXad85AY7UWxgCqtfCP16JpyuuvrWJHQpi32DCj5JA
         jYlHK6JYTtpIRTjTtAqk7+G0MGotcdSdSuFCi8PrgFBMvyzp9na8aNhd3AGDteY8s8qb
         rr6kuiSbcKI2eYqiL+9jsL1DuWSJHIGEiO4u3GGVo/Vs6KyHcVOlZkZ8XeqLzaOM2q6C
         w1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769188667; x=1769793467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x45fhEbj3h0C2LSTj+jCNFve88XybM2CA/P7gFjNDUI=;
        b=ttdYjmXvtYiGqcC8Dk2cUeFxXbqNilgAHJ/Koop14oK9sYWVq6/D8hycZw6QZw6Pp0
         T8QEP1p48giJ81L+/E5XHZRB8f6SIBIxU2tphVf6dglHK/LUJ1WR4Mmh37IHp8MeovD9
         hXclR0PmOPRM/ONn+W4ZDH8Qqvnb3+2UbgSJpK6WGot1Vv5gH1Vo+P7/VqwrDMDdangx
         MRn7l2ETEgg7pvonYmknKXpejA7Wo3iH2ZanAHtRmeQLFwC3mMsBCVCouJ4aOqEweezK
         TT3LQIl0EDL1o2UI78FauuDdpznIZvhsX4ad9rSemjCJvvntXx//VjQw1uTcHTUSDxc1
         LoFA==
X-Gm-Message-State: AOJu0Yy2TcZw5NIMAej6imLoL3K3cpSbkz0EPfTV5ggZbhhWdAVTq+S8
	uM8TpXqgCALeFOSKHwbRefLaVcQDI8bk6Y+o2rAW2uNcp7SSin4zVv395NmERrDZRxu3EdAcXxk
	OlQfmsQ==
X-Received: from plzu4.prod.google.com ([2002:a17:902:82c4:b0:2a7:5a4a:5bc0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a4c:b0:29e:a615:f508
 with SMTP id d9443c01a7336-2a7fe6140b7mr31077805ad.28.1769188667228; Fri, 23
 Jan 2026 09:17:47 -0800 (PST)
Date: Fri, 23 Jan 2026 09:17:45 -0800
In-Reply-To: <20260109231732.1160759-2-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260109231732.1160759-1-michael.roth@amd.com> <20260109231732.1160759-2-michael.roth@amd.com>
Message-ID: <aXOtOVrr2SpnGDEg@google.com>
Subject: Re: [PATCH v7 1/2] KVM: Introduce KVM_EXIT_SNP_REQ_CERTS for SNP certificate-fetching
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com, jroedel@suse.de, 
	thomas.lendacky@amd.com, liam.merwick@oracle.com, huibo.wang@amd.com, 
	Dionna Glaze <dionnaglaze@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 09, 2026, Michael Roth wrote:
> +KVM_EXIT_SNP_REQ_CERTS indicates an SEV-SNP guest with certificate-fetching
> +enabled (see KVM_SEV_SNP_ENABLE_REQ_CERTS) has generated an Extended Guest
> +Request NAE #VMGEXIT (SNP_GUEST_REQUEST) with message type MSG_REPORT_REQ,
> +i.e. has requested an attestation report from firmware, and would like the
> +certificate data corresponding the attestation report signature to be
                                  ^
                                  |
                                  to


I'll fixup when applying.  Thanks for the *fantastic* documentation!
