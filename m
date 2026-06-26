Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA72F7EED
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782495987; cv=none; b=J5/fuCN0PEP6/T1IMciM5HHzIvz3Ri7EZtPXWlhe9umxcfsp1P291gpda/GEjeYI7jagcrirQp+amsz3BQnYgN/H9X76LSLxIf8+pInKxCzcbSKYVfxKZ4H9wmqqOoFD7o8ITrGAI7eiJN1oG4BKdMB1UQx4Bvlmo1pgjuYTo7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782495987; c=relaxed/simple;
	bh=J8aIGZigHML28IHFefYArVN5OECpup/t70vEj4gkDGY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lQvLbH9Ng3G+McRwHjCdDklZm+38hn4P1YnVK33rD7GcuvF2Gw0bwWmxUdbTTeAm/NPu1bj5MDUqhz0gyHvEriU5J15atbOSIJMgqrg25ETy2uxk5fvAGyzcE3Lg3M7XOUfMLAuAhhqdsmgxarW80zw5w+liRKeSn4y1rW13fZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtdE7VI+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUyzm7CT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtdE7VI+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUyzm7CT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782495985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J+LmZwe12CEjv/lR2veCJq0GatrkSSylTfQwITNGjHM=;
	b=QtdE7VI+1A9ouF1NLT2eifwJc70YtbDt9O9P7JAMr5kJGvkP1xl1wbSknpdIph1LEy9cH+
	QkMO7q4ySxUmpGTCpL/tjECObB74s7t7PPxbb/5pjcNREm14itQ5ki22mSCbRW6bL6smUl
	GGyqitv96bLUpGmfSX7IwGSvcXy2vXQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-lLMDIzvSNqOC2mMIGHNTzg-1; Fri, 26 Jun 2026 13:46:23 -0400
X-MC-Unique: lLMDIzvSNqOC2mMIGHNTzg-1
X-Mimecast-MFC-AGG-ID: lLMDIzvSNqOC2mMIGHNTzg_1782495983
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46cfd1fe676so671113f8f.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 10:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782495982; x=1783100782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J+LmZwe12CEjv/lR2veCJq0GatrkSSylTfQwITNGjHM=;
        b=KUyzm7CTMY524u8+YfokQo/fJSbcQTA9FsljO2hn1hvW3/0dTayff718QikiM6PXsi
         CDm6uKhT+3ZQMZGxUHE3eyf9FMLgtck/QvEVrU69ObMBkaWZ6ONReSbvG6PiIoTx80u8
         GZ4DKZYBrUfDgcY0fRT6gW1fc5FSTpcjI4m6K41AzN/OJAVpk4xJko0iS425lwGGYJOf
         +7GJ2uW0hy0GWI0tlWS4npVw/HcZjAtB/y2Fzs8kOs5sbL5LL9l4Q1EvKtMFB01cMlYk
         VgTRMBsrJ2PfFLZ6xMLG0pM+c1EeqvnnYD1CLyL5mQH2ABSLOO1rstnErw8nsM/IG4Rg
         meOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782495982; x=1783100782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+LmZwe12CEjv/lR2veCJq0GatrkSSylTfQwITNGjHM=;
        b=IloJHgtHCJi62KlUiLMtZSUt5tuW7YOxxufJc1x9kVCr+wUXmTRRmG+ELvK+SjR6or
         NaTxx0TpEPha7v7M0QlBje4cK3HRg8tMgz+CRKFDPy+F+DDgc7H4ihN/uNElqF7dfJ9d
         IkIcJTvcRCGPFPjX552XmzfjfJf5TL4Z4xKIJM4Nu5uLCIQaQuF/CXZ5JuJtB1Far0/8
         qw2Im8Wgf/2qSdvuXuQgTkYHs4NFJ1euFUeyUzjG2pISjdzcy60nYjiMiA+9AhU7j7qt
         4d2SNTgF01bOg2eSU+46mh1CkbB3fa/D/iRbbSBxCxStgflRbITPozgSa3/ihZchpaS/
         sSrw==
X-Forwarded-Encrypted: i=1; AHgh+Ro8sjW2YJbKSxNpqf47wi3pHpBfMihruCTHvDitPiqjFfjujbcW2+W1uJOplkI+YPP2eKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLOOpuz90PaBKTD0oDhzyJaEYsKbQ/IEh9BA/84BdwAcYKYtI
	OCiuUoiAv4pt/9JmJJH13K416nPwy55W+4sBmp9zgLQ/yBJCOYmzRWqfSre3cPCOtSjtw6ZqyC8
	nlRKXnR0yZ56Bj6pfdL/UsTEY6ttB5Cf6mNXRMuuQXyFRRCcpiOscbA==
X-Gm-Gg: AfdE7ckD2o4U9WITo3Y2zA02LItT6iYTyG/sMXwOW9JCDw7uOT9ycwyw08cXUiY5xha
	ZzfHlL0Sd151vLV8CYhoeFlAa1ghEcB3VZu3E3WFF3y+dCebLey4L2c6a/oYs38W9fL2Wed2o9H
	pZeyIpXx/psZ0wHRQPkB+IcP3F6ZusmJVEzRffX4fPpAxbpXousoIrFb1gC6ULR/IAQkdNpPC8A
	xpy1Lcehb3cg6ifN4/gwhcf2sLyDAUedtwFRdrJOlOzjSUGQzHsk1NWDxWPzWTJyrmaqlsl+CwO
	TcY2xWFvOBfv1qGbTb9nRACIpvVS2WAcdyj0PHlFREWgnatCLA7g8rx1pFfdHOg6tYs9H7Rv6u9
	udEHgofPUPgHBAQ2nz0asRp/bbNYPqDkzxbXKYkwE21W9DYTaNXyoleRYuL5CTe3jqs7oTTheMy
	+ITCwC2/WHA2FtvJHY
X-Received: by 2002:a05:6000:230a:b0:461:a1fd:6be with SMTP id ffacd0b85a97d-46dbef25978mr12605894f8f.7.1782495982544;
        Fri, 26 Jun 2026 10:46:22 -0700 (PDT)
X-Received: by 2002:a05:6000:230a:b0:461:a1fd:6be with SMTP id ffacd0b85a97d-46dbef25978mr12605860f8f.7.1782495982120;
        Fri, 26 Jun 2026 10:46:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279bc77sm25475862f8f.32.2026.06.26.10.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 10:46:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and related issues
Date: Fri, 26 Jun 2026 19:46:11 +0200
Message-ID: <20260626174620.1819772-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sasha, Greg,

this is the backport to 5.15 for the above CVE.  The fix was relatively
simple upstream but only due to years of refactoring and cleaning up
of the code; fixing from scratch is not really feasible so start by
applying the patches that are needed.

Please apply this instead of v1, due to a missing line in the last
patch.  Sorry about that.

Paolo

David Matlack (2):
  KVM: x86/mmu: Use a bool for direct
  KVM: x86/mmu: Stop passing "direct" to mmu_alloc_root()

Paolo Bonzini (5):
  KVM: x86/mmu: Derive shadow MMU page role from parent
  KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes
  KVM: x86/mmu: pull call to drop_large_spte() into __link_shadow_page()
  KVM: x86: Fix shadow paging use-after-free due to unexpected role

Sean Christopherson (2):
  KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
  KVM: x86/mmu: Ensure hugepage is in by slot before checking max
    mapping level

 arch/x86/kvm/mmu/mmu.c         | 192 +++++++++++++++++++++------------
 arch/x86/kvm/mmu/paging_tmpl.h |  30 +++---
 arch/x86/kvm/mmu/spte.h        |   5 +
 arch/x86/kvm/vmx/vmx_ops.h     |   3 +-
 include/linux/kvm_host.h       |   7 +-
 5 files changed, 147 insertions(+), 90 deletions(-)

-- 
2.54.0

