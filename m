Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF437340A6C
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781804634; cv=none; b=mgdobGzpnBXS0TNJDgjaaVAdHeM99yjmISo847vi/p0Ub0sp98PpHfHElR4dK1lYqCxTx/N63XvqmZ+B3ViNXgiSay2fOMyU2wxLFEBINdQcxiXe6O5OPnE7oLLUiZXQX1ch1o8PIU5DcY1ju2s0zvaTJQLA/2z0mrzf3SAXDjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781804634; c=relaxed/simple;
	bh=fw00JFi0dEHHNfau5dofIw+cE/GHLiKdl2owFIKSUA0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=X2O92u7OMnT0e+bMdR/Gw9PM3VYdq4bkw/P0vOmYDtAcfA6RsRjQ27AGWQx+VQnr5CLMUS4ME6EMiW+p9NTfY3J9KX149Eyt2pfrc3JgeTUnpH62JwR1TETs03pI1KZ+zIgIWUxQVa4dycXXRCl2U0fIBGWaHUanCx5IxPgvjKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ro3x5Gwm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ro3x5Gwm"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37c6cc4e179so1440732a91.1
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 10:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781804631; x=1782409431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLq99k0RbX32MGD54eNtMUTGKLhlOR3MAsN7/4xuAC8=;
        b=ro3x5Gwmt26tChIj3T32WoJm8J2yGmzMsSam5CxYDYDpl55a7qumHVsEF/iZbXx6v2
         zL5jlvJe/QN1pS2IWjFn2aNthzjGuhDBVV10TLaEMgcpj2caxXkFu8oaQKFOO5QEo9YQ
         fg1DtfPGk3i42fLGjkjFp0PxLj25kWFlyHDAsEDXy1URgNkwUhis7tCCqee4oKzbdOZH
         1oM6ICntGyelkQbdaZC8BxR9ZVWktiYCfqZIaam1b+YmdFvCqdqwd7PNK+yMpCUZB/vc
         bozqwQIMwuMQ4/m0OLDGESsTIEcng7nB6TSYdaxp42VX3A9R+V6ZhcFR1dY4Ln44xRRF
         7Uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781804631; x=1782409431;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CLq99k0RbX32MGD54eNtMUTGKLhlOR3MAsN7/4xuAC8=;
        b=c/ZnoRFAAHOmGrPwWmgd/bUI9XTAajW8haY4kWccxN/t6SNZ+g4JDs8jhDvFG9R/vP
         GOyKFnMgVfXej0RmOWl51skoH3FeKihr6YC5cXIHgPsJSwZhhZSgfuhosa6RwX0BUZC6
         4g0uCPvyPkoPYA3J1TDA5VCnB1Xg+aHBDtb6KDPjqGMUD7DvA6kWKw+a+UNSMfLW6OO2
         a8CaNzHU9SmIGi5u1M01V7DK2YpMOjJIIiTkr/18aOSOjVJIsiFfGyqofXP3eXZz6Ddt
         9brTSshuXXt5Dj1a4YCRx65v82ZfGIrLADNhUXsIyHzWLKdOnAm1039Ag0mA0ctO6eHm
         /iOA==
X-Gm-Message-State: AOJu0YwLnyhaGMYbg+R1VHdc1ls/OP6LpH11VNhFixDiTmsjzekLB163
	5Nda47ZAPXKyOM+8L9iw4c2yDQPfW6urPLKeJHPNFxyKNbApkk83pwVRIzsyixw+LE3Xh3XtNjT
	aD6T67w==
X-Received: from pjbmr3.prod.google.com ([2002:a17:90b:2383:b0:36b:bbb3:1b83])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d610:b0:36b:9c4a:e05d
 with SMTP id 98e67ed59e1d1-37d160b500dmr393265a91.17.1781804630927; Thu, 18
 Jun 2026 10:43:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Jun 2026 10:43:45 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260618174347.1981064-1-seanjc@google.com>
Subject: [PATCH v3 0/2] KVM: x86: Fix VM-Entry fail due to stale CR8 intercept
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot ci <syzbot+ci493c6d734b63e050@syzkaller.appspotmail.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Carlos' fix for a bug where KVM neglects to update TPR_THRESHOLD and runs
afoul of VMX's consistency check that the current TPR won't immediately
generate a VM-Exit.

v3: Call get_vmcs12() iff is_guest_mode() is true to workaround a lockdep
    false positive. [syzbot]

v2:
 - https://lore.kernel.org/all/20260610214523.2905255-2-clopez@suse.de
 - Call kvm_lapic_update_cr8_intercept() from apic_update_ppr() instead
   of issuing KVM_REQ_EVENTS from handle_tpr_below_threshold().

Carlos L=C3=B3pez (1):
  KVM: x86: Unconditionally recompute CR8 intercept on PPR update

Sean Christopherson (1):
  KVM: VMX: Grab vmcs12 on CR8 interception update iff vCPU is in guest
    mode

 arch/x86/kvm/lapic.c   | 2 ++
 arch/x86/kvm/vmx/vmx.c | 3 +--
 arch/x86/kvm/x86.c     | 5 +----
 3 files changed, 4 insertions(+), 6 deletions(-)


base-commit: 9d4853b044beefa21c4ee3e18c40653601a64ced
--=20
2.55.0.rc0.738.g0c8ab3ebcc-goog

