Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931AC40DFD7
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053096; cv=none; b=MMFXFLJ4+wc5I+DB36SAcAG+ayZJs4P0SGKfbunz/yuf7RqNXdHbQo79Y2+SRB1rer4vXxnfBUUCqY32yrMQbCdfNl5/Wpw4mC+nLCjKbUXZSo37FOMtuS0lN302MdCYXyqtF2fS1M2AuaMP60xVpIN+qiwpCAHSlxADuoMSOck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053096; c=relaxed/simple;
	bh=jKkt1iNvsxHUGA5bhDGX0xwa8i7BsK3NGZi5C0TuX88=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WaRxzxPf87yTauZg8RDkWX1VhfnMTwbQh+pXswXQRzUQJuZ0HqTBiGgGjC48CMeUqBw4qxLRUJPu+5JFX8rkfmJdLLE9Iyxioy/b8RvxIX9BH10qEAK467MsCyle4bAVdNjvEFCC5SfX6jJA7o1cLUNUsrin3SkyJqS2bYUbtgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9tWdK//; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oek6L6iU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9tWdK//";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oek6L6iU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792053094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rFwbgB4b0eAbrHpOLeBLl4+Olmm9e/LTPTBUOO2whA4=;
	b=d9tWdK//oKLqGLEAqWCARKejUWSSRh1K9GU8RDsYCNhFnGr6Cmq+Qx30mO0M5A3e3K3c6u
	3mK4Tm/fJ/yo0MlsVWprdAMFqxxSM7YIdSyE3UPCyl9tT/tj5YeP4KINz4rizyUA8CP4Jq
	jcWK3BDsi6/hFUA3DtiMaCt3jWkCWdM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-O8XwmQCBOoGUiSuE7aj1JQ-1; Thu, 15 Oct 2026 08:31:32 +0000
X-MC-Unique: O8XwmQCBOoGUiSuE7aj1JQ-1
X-Mimecast-MFC-AGG-ID: O8XwmQCBOoGUiSuE7aj1JQ_1792053092
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4870142f030so3000095f8f.2
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792053091; x=1792657891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rFwbgB4b0eAbrHpOLeBLl4+Olmm9e/LTPTBUOO2whA4=;
        b=oek6L6iUeGjREc3JiWBpVXJiyPy8ejUPBkUBXvgTaxD9ZYCoxvl4FFMca/y9FNBxI7
         1w+yy069JgSq1nLYJR+WD7QWB1TBt+disFBnI/GwgUDBnzgeuWdJz6V2/F2MWaAVqu47
         rS3BG1KtRVb7saXiKPSuLsLCNL1dHXiUeJXiZcxwvBeZe60bRRdzAzvUe8Sh7Yp0tbzU
         go06iPJuXL0XKlsGU0KFevi5QBcQMYDe9iz8+RVQ2fOyqw36hSBLi2E/ylPj/tHezis4
         b5mc2nhXHrJS4G3c3MUNoUnWsrlWYExiy0a0prbGjGzxGnMLO9k0iSaT9BnTG7ECmUv2
         JDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792053091; x=1792657891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rFwbgB4b0eAbrHpOLeBLl4+Olmm9e/LTPTBUOO2whA4=;
        b=nJXZCIHfHTHhL6x2iKpi/lsFnjc3ee7M6H4s0FzdkIQ/B3f9q9Xt/fgQ1GNwmfBRWu
         Fgy7PIA3ieeqw4dg4qxWtrPh2Ib65GiMbI+4Vfgug75gp5WrFLyls9IL9dhpR0lSFVk3
         pa8lVCHmh56UfxSejN0vPX6MxwMx9aXE0zj6DwlyTaq6KwDXUvXN+Jmn+8S0XGD1MLZ0
         PdqWFrH3H7Ykxueo3gqYxUhhvCEl5B+/L8InJx/oD2kveIdiMucGrIVeo7TWXyQIRnRe
         dsJGX5rMBhGby9DDqhDgQ/3Au7gbqZKuDJNzqsZbHsVIOWPg/0pO4C7+GUdX2TcKZ9ic
         VY6w==
X-Forwarded-Encrypted: i=1; AKwUvBxHadW5Dd60d0MOKJn2DbsTdqrQgA3fJ/wXU8gs16sxWBUO9sjOcGtouRlu1VxKCFy5ORQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNracjZm2tP9oFiJ8v/gt2ESxEusgtxOyVEqx4QyqTBBZehXIB
	5e7zA2+zDzKtzowE9yinHU4SZfZk/zBaHjZUPdRcwdZRvk0RHqCGiGctffqg0qT+2AfolcRjqmk
	/WR2r/AedzPPxosxK9vFWshBm1qWYTsn4rECFByNudpmmJS5l1iEKQNJMRnlx/g==
X-Gm-Gg: AYBFou3AqbfEVw+c9BERkcA0QjNI14Vz7KflywHnV4EHOenLfzSNLjV6tgl8MQVsiP0
	IcY9efM/fj/gEqumv134z2sGxLmGiTRZ9VQORs2GU9sHiFQyeRHINOQvAMHGmzqejY+IFxjtocX
	JuldIb09LuqwgEF2IoB/opQSCGjEp0FpVJ6702bnldP70hPE3P7VT3NWigZyalcSLnsgHb0JrRF
	IZhFrQO7jortAQXcLIJ2gNjLTQ4iAPUl40ysrF1vFCLyoF8LlJCzhPCZq7SyCKI/UXQ/9I0oVR/
	tenfqhFEBVi14GXX9EHOW29NX7johSCex7OKJHmcqbrsa8UkcxT9e8PoH1DLIggYiz4nM93pzMq
	ASzj6NASXFXlAugAwEvuSIWEM3C4KpQnKY4eiIPIb6uSz52UHKjJbmcichLC8e/BWuH14a9yHu2
	+Erd1g
X-Received: by 2002:a05:6000:4a14:b0:487:15a3:1cab with SMTP id ffacd0b85a97d-48dbaadb081mr34984951f8f.18.1792053091568;
        Thu, 15 Oct 2026 01:31:31 -0700 (PDT)
X-Received: by 2002:a05:6000:4a14:b0:487:15a3:1cab with SMTP id ffacd0b85a97d-48dbaadb081mr34984900f8f.18.1792053091203;
        Thu, 15 Oct 2026 01:31:31 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48df50bd11asm3008872f8f.8.2026.10.15.01.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:31:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 0/2] KVM: x86: Reset MMU back to the root MMU when leaving guest mode
Date: Thu, 15 Oct 2026 10:31:21 +0200
Message-ID: <20261015083123.790030-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a bug where KVM fails to unwind vcpu->arch.mmu back to the root MMU after
leaving guest mode on a failed entry to L2 via RSM or KVM_SET_NETSED_STATE.
If KVM also frees nested state before the next entry to L1 (or maybe even
after?), trying to construct the shadow root will hit a NULL pointer deref
when trying to get vmcs12->eptp.

The only known instance of the bug is in patch 1; Sean's patch 2 avoids
the moving the reset to the place where the vCPU goes back to L1 for both
nSVM and nVMX.  However, it conflicts with pre-7.3 code due to the separation
of kvm_mmu and kvm_pagewalk; and it will also conflict with the stable-worthy
v3 of https://lore.kernel.org/kvm/20261011001303.723721-1-mlevitsk@redhat.com/,
so it will only be applied to kvm/next.

Thanks,

Paolo

Amirmohammad Eftekhar (1):
  KVM: nVMX: Reset MMU back to the root MMU if loading L2 state fails for !VM-Entry

Sean Christopherson (1):
  KVM: x86: Reset MMU back to the root MMU when leaving guest mode

 arch/x86/kvm/regs.h       | 2 ++
 arch/x86/kvm/svm/nested.c | 8 --------
 arch/x86/kvm/vmx/nested.c | 8 --------
 3 files changed, 2 insertions(+), 16 deletions(-)

-- 
2.56.0

