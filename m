Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064FB4A3F08
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057922; cv=none; b=Y+YHVXMJ0+v9sWPTzXgWW6ff/jbyLN8OjjVWrRxSfSl2FcZPrx0JVZIqn0Z+gabzcNSYhB0/BbLV176U7pAwFDQ/EuBjYOEoKa5gYYfC+1ubLKgu0VRTwG6N9MpoZzAPMsGWEvWXS9+5iKuM0zrW92ivpQM08XtlXDLu6n5/Dfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057922; c=relaxed/simple;
	bh=h1WMbnMbzIi253lfdQ+u9FLPEFTOIsOzHEUUkwnXNqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BsOGMns9A5ZMPlSAr88JB9+2nZrB0+dSQQpZM2WEP04AxS06udXDv3YqO6Sl17SRulNSl1k0Tqnjgtrmr5IO2Tg80beIYxeNaPKbM5Nt4p/wexA++2TAA5TtXCuspfr4dV+FkrxqgPIH8qYCIaccB2QIDSC6p82nlVJQGFzxvtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UnSBobRf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sr6Ugn4v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnSBobRf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sr6Ugn4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792057918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iSloRlPr3slvcSabouqCfbFikV0zEeUbF8yFoLWgrFc=;
	b=UnSBobRfaksXNjQa+TVWwdBcULpIeIQ3sEbxV3ORoLMo5FXo+w8Rle/GHp3ZB25AdNiNt5
	b4EQxxfiv5hgx+EUn4D9UXXHsVHt5Aw5S1rhzFontIVFMwvfxbovQlbC/TYudqbfYRXjLj
	x0lECdlC/I+kOLbiE9tuRjkZaQh1+wY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-bRFKMuKVMwO9FguYpZd8nw-1; Thu, 15 Oct 2026 09:51:57 +0000
X-MC-Unique: bRFKMuKVMwO9FguYpZd8nw-1
X-Mimecast-MFC-AGG-ID: bRFKMuKVMwO9FguYpZd8nw_1792057916
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c430f0f01so1119883f8f.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 02:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792057916; x=1792662716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iSloRlPr3slvcSabouqCfbFikV0zEeUbF8yFoLWgrFc=;
        b=sr6Ugn4vNJa+IKRRChLBwLXfQkii45jqcBGTJ3J4qk30iby/CmXcIaakXlAet63fVC
         3yjN0o9+5HoiCIO1nJONS3Egv1y4lG1CBZiwW81GS/DzIY9fTmTpwMV7pdREAa/8BhEq
         i0O1MVI4CWRTgxygHJizlZezi9aZF6WVqKkOxAsgZ1CdBlus9wmHNb6iIjL9hI+XZRc/
         N/ghLbapsrOnjkEmaLkYraGc3XmZSWF3AfbPA3VNE2rsovCfD1KwvBZcwC5jjipeJTNV
         4J4KmK0Jp3e5aM2xnnCvjWGFaT+bPI0RfH9r3K/uLKi2Sul92lHgnvzaJCahGJLDkAG4
         ViGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792057916; x=1792662716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iSloRlPr3slvcSabouqCfbFikV0zEeUbF8yFoLWgrFc=;
        b=VmEWKgntZM9rnrM4+h9GM0oCtZZPeAG181C++lij26kkDMfHF30cNnRPVH1zTq9fdY
         wf9JFJvVqyMuHjWqZUe6XapEY/HfhjJukj4JmGdcRl+XtRBz5c+sVUvYGZg+ZsG8prWf
         +InffuHXJxp2iJu+0i++um++E2qNcypG+nMsChxsFHNUo0aepSjJKE1jwhtMGbwo9ljN
         EbB0E0tBVB3vMZ1BLWCVjmZIt5wUeoeEurcngU2PaCT6b3Vvq9o6QD5Fq7dRiTFZtOPt
         3mZic3aF6b8MV7dLOeytV2jJT1/H3M8XDN1EbhzFtxGZ2uJD/pwPgeUBjNVt7q0Qpv8n
         Bdog==
X-Forwarded-Encrypted: i=1; AKwUvByIVkeE7BMHnSQRoVpjc9RYCyMsRkZtO5MIM7HjLTkymjrVaRn0TulUVT1bN162vLEMYYs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLppDRIwaujiVldazncXPFN62HPVZUN0uiYe4+olVbMiI9Zh9VA
	+JDzu49sv01XzigIMFAbK6sJ7dRXGCPpRS+Xik6Gde4wKrGIRskEqB60OmFiRaIGdW8MmA35HnO
	fYpsi7JmF/B3UjEuyG4bYTR0M2bGPr8IGAJmPoG+ghzEdvis3RCJXww==
X-Gm-Gg: AYBFou1W9gt5A1O+p7RLJbthoPlvnoRbhDYFgHPbFHHGKRtsl9KJ6ijk48NG1e5e0+d
	3VDwXPdJDB+U/g1bY0g/GTMeIS+yFovMs/8ogCJCtRe7+Gm+fbEVOGaBI8ZZAflAZNSU26S5uTD
	EtYWNiOaz9+Q9WZSNHJ08pDwplxd7msXom//rsPM9BPCslU5fgAw/bL9ksvEB0EZgI4CWTIQV/l
	5AR3eDwsl/JRDuELiBV2jAJhW3L0UiUs6AI49bwe2PV3T5ik/qtkNuEmZrHNszw/mC5AGry0jz+
	KJhcnXUYNyE7TA9HSqPmEKLNUOUbLC1MFPE46sdILZFupyiIk6/UBrNBtuMuYCBItzX6XwNO8MW
	M39zTjdWdITlAnOzxEpH1XgGuBb7JXdwa54vXOBCYOC045RtWraO+jXSXt6DFyKv++OKtiXChch
	Ir/lYZ
X-Received: by 2002:a05:6000:2407:b0:487:1ddc:aaff with SMTP id ffacd0b85a97d-48dbace40cfmr33733789f8f.44.1792057916419;
        Thu, 15 Oct 2026 02:51:56 -0700 (PDT)
X-Received: by 2002:a05:6000:2407:b0:487:1ddc:aaff with SMTP id ffacd0b85a97d-48dbace40cfmr33733768f8f.44.1792057916074;
        Thu, 15 Oct 2026 02:51:56 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc6b82sm18207703f8f.51.2026.10.15.02.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:51:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] More KVM fixes for Linux 7.3-rc8 or final
Date: Thu, 15 Oct 2026 11:51:54 +0200
Message-ID: <20261015095154.815793-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 4056b3c9d3c92ea45955641dbafeb9b960e146ef:

  Merge tag 'nios2_update_for_v7.4' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux (2026-10-13 18:06:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to c8f4cfe1cf93bce924e27f2abead7a4c4a487505:

  KVM: nVMX: Reset MMU back to the root MMU if loading L2 state fails for !VM-Entry (2026-10-14 16:42:40 +0200)

----------------------------------------------------------------
Even more x86 fixes:

- Avoid a false positive panic in the #PF handler, if the kernel triggers
  a page fault within the asynchronous page fault handler before the flags
  are reset.  This can happen for example because of a perf NMI.

- Always reset a vCPU's MMU pointer back to the root MMU when loading
  nested guest state fails during RSM or KVM_SET_NESTED_STATE.  Otherwise,
  KVM tries to run a non-nested guest with a nested MMU, which can result
  in a NULL pointer dereference attempting to get the nested MMU's pgd
  (EPTP or nested CR3).

----------------------------------------------------------------
Amirmohammad Eftekhar (1):
      KVM: nVMX: Reset MMU back to the root MMU if loading L2 state fails for !VM-Entry

EJ Campbell (1):
      x86/kvm: Don't consume async #PF flags on a kernel #PF in NMI context

 arch/x86/kernel/kvm.c     | 32 +++++++++++++++++++++++++++++---
 arch/x86/kvm/vmx/nested.c |  4 +++-
 2 files changed, 32 insertions(+), 4 deletions(-)

