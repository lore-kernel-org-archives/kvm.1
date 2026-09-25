Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700F32AD3C
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358333; cv=none; b=Nx+QJAKrNKFy0u4eSmVIwFgq/GfOY9c6VX+PdYkDW/nP4r2cWhXBgiO9NzY+Gp1ak4t9i/35xau71GS20GHFG6NawMwaWenx89Ng5yZNZZmhHG9NJA8kxBsmHyRZPYn5q4RAavfk1WDlXNGQsgF6JKd1wFX+FnspWXxTNN1yyFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358333; c=relaxed/simple;
	bh=yepYEr/og+tpCitnzkoRpHGS8DW8WJIipwLokUVJ8hY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UYbC0T2Yt67NRIkoTAUzNsIJhfACSoCzSbhATpLFXUkx0/pYJvU/VdsMPTn2w5efTId8yPJu18bv35QTYJyMaeFZbj009fh4ABPEc/61vUE7TI9eaQFNUdKWVk414r2teCrScgTH46w5Tx3/agnIv2ApAXkb77FuNjRovRfs3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0RMYx9K; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0RMYx9K"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2df375fb9b2so11364475ad.2
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 10:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790358328; x=1790963128; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aRk4EJRTpE4YTap1ZO113RufymJClcpVSZXiwMi1HFs=;
        b=C0RMYx9KbXx8XhN+C6Eea/y/Zs5YRNhGsCU/KeEHasPbGPMoGjpHRxRodTskFJhd5z
         ESoG5vuAxTZJEBuKLzvNoEaK+8uhvEVfdUp+GNTBTkgKTEh2q6X/TEd1GxT5ciiuxmpC
         Dt1HXPWuY4DmtFZlgmLlcfDhEOT8HIi6YXA8/rwKnvQ2Q3ek7JnKlETIOaRtnosEO6YF
         Efo6ezOlRryAg2vjT6x53yPLitiWhpVHzyny2PXCDLb4/DwwPwNEizw5F4SBkn0ejw6T
         +LUrTmVgOJv+bCuFgBd5P4s3h+ahN0ShI0mc+yUp6ADI2GF7P97I4FySw0ze5FtLG/+i
         jlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790358328; x=1790963128;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aRk4EJRTpE4YTap1ZO113RufymJClcpVSZXiwMi1HFs=;
        b=HFCLRMjGjS+gU/MZ3V+wgRV/Bzg0/VoUlU8D2o9Cf4d6bfORycpVMgawMubIX5AXVn
         tBuSC1vj62itzUpyg0z0OYJT6oUl2x29DRcTCE38yIXa7APjBpUdRO7I0byaEBv+p2Hv
         678oCrOU6qhg70LG1GUDJWUvIhV5g2vi+IK3Cmq/KDF2IY+OjAwCvzidSBS6j0QVmmKk
         mr4TvRCUKnZ4Ad2wAdCb6+ErNdCd4GRFvYLfMA98DY3GJDJoIlMUl5OSMwODneVq+K2A
         0U/MEPw0HTDhRjLxRQ9cxCYYPX7jT3RUhTYgK/kNm5IvEddEPUWrI7n/oCR6bsTPIG79
         0yZQ==
X-Forwarded-Encrypted: i=1; AKwUvBz2R9EgtKE66plRrWH8Pd8grijwSRTZk9c+4VHHnZW8rqwVrcaGBpivfX2JDQsk977Bz8g=@vger.kernel.org
X-Gm-Message-State: AFuF++nc/EVjnJ6u+KTCT4TjdoL2a+RG6YwX2vLjcUXA4sS9jocR9/1g
	focihJTR28A085FbmhaJOdvH+0Vq8UkmFjn395+I+p3V6wujkn12M8JWuEVpLd5sd17vlPkBHze
	A2aQeEw==
X-Received: from plae1.prod.google.com ([2002:a17:902:e0c1:b0:2db:56c2:9cb4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37cd:b0:2de:c1f6:5b20
 with SMTP id d9443c01a7336-2df7dc356c7mr45723265ad.22.1790358325988; Fri, 25
 Sep 2026 10:45:25 -0700 (PDT)
Date: Fri, 25 Sep 2026 10:45:25 -0700
In-Reply-To: <20260721050600.87268-1-shivansh.dhiman@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721050600.87268-1-shivansh.dhiman@amd.com>
Message-ID: <arazNV7Y93gnflU2@google.com>
Subject: Re: [PATCH v4 0/5] KVM: SVM: Add Bus Lock Detect support and refactor LBRV
From: Sean Christopherson <seanjc@google.com>
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, 
	kvm@vger.kernel.org, x86@kernel.org, yosry@kernel.org, jmattson@google.com, 
	thomas.lendacky@amd.com, nikunj.dadhania@amd.com, ravi.bangoria@amd.com, 
	santosh.shukla@amd.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 21, 2026, Shivansh Dhiman wrote:
> Shivansh Dhiman (5):
>   KVM: SVM: Refactor svm_update_lbrv()
>   KVM: nSVM: Disable LBRV in nested control cache when unsupported
>   KVM: nSVM: Sanitize nested DR6 using kvm_dr6_fixed()
>   KVM: SVM: Turn DEBUGCTL_RESERVED_BITS into a helper
>   KVM: SVM: Add Bus Lock Detect support

I'll send a v5 as I have variety of changes (I already responded to each patch),
and I'm not in the mood to deal with another version as I'm quite grumpy that no
one bothered to follow up on Sashiko's bug report, or to write tests.

I'll also post a KUT testcase, which I created to verify the bug Sashiko pointed
out as well as the fix. 

>  arch/x86/kvm/regs.c       |  3 ++-
>  arch/x86/kvm/regs.h       |  1 +
>  arch/x86/kvm/svm/nested.c | 26 ++++++++++++++------------
>  arch/x86/kvm/svm/svm.c    | 28 ++++++++++++++++++++--------
>  arch/x86/kvm/svm/svm.h    | 13 +++++++++++--
>  5 files changed, 48 insertions(+), 23 deletions(-)
