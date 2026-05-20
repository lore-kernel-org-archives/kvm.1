Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9013D1CA2
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289111; cv=none; b=GepkuutJqyHdhKbyqmM2yowCIVMld97vmOH/E21hXFg8SFRKdnv+b+YVRPBaRrmqT6VCKC6OHYyG6Sh1khkEL8921meKSJPaoX5fpz56/3O4m1ggG9KC29SNzecok8ftj0EB/kG36LnvDWQPHKdxJ80jOZ+uiY4mIamq/X3V8GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289111; c=relaxed/simple;
	bh=TOONv9D4eAG2DGvFTjISKLQKbTYyTvr3YudCllkR00w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WvFBOnp8FqmK9nQv2bQS7+CJe7lhX/F7+DGhBkhJhTFp21c03ylKB0wrmOe1yrNZ8gP9vmYGcsNBpa5TbHI6C2LbJiVAMfdSOMMNPG22BZGSCiJmXxlUIyJeuOQUD3etwe8qosFGQy0b6n77XJdzMlb41u9Nmq/v7dPDLIF/86A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1VOdLZv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ws/Xrn8s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1VOdLZv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ws/Xrn8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779289108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PMte6gCl9iyQkJk8kzgWGKq11/9eBOqAPtS55KMlxKE=;
	b=d1VOdLZvJL3HxHtmpcRfPwcXpl9HUdx7YW352lESfAcJ2y7sBXIBVus+OFKgYQjjzGyuQO
	/JhoKrb86QplA74YVXreZbQNtztbaxb007iVl81cq50M8okoKWpPamjGZ0Alf1bIKIihbm
	GQ5Q6SWHR3Wyukt/69J+MdIyuOldJNA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-CZ7ozoTXOv2nr00Ukc1g6g-1; Wed, 20 May 2026 10:58:26 -0400
X-MC-Unique: CZ7ozoTXOv2nr00Ukc1g6g-1
X-Mimecast-MFC-AGG-ID: CZ7ozoTXOv2nr00Ukc1g6g_1779289105
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44a3aee3813so2240912f8f.3
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779289105; x=1779893905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PMte6gCl9iyQkJk8kzgWGKq11/9eBOqAPtS55KMlxKE=;
        b=Ws/Xrn8sMuxbVmEz5hGTW+jVZxo+4+6T9Qe+6mcwZ9WRSF2Q5aDNsBnAdtDrzKmHRJ
         vZEGrdsy5/ykdzrPY/ua1zJYOEnTM0K7GEqW3AFYEAV5a0Y9bP0TwANuBTxupeKhFpJt
         RAIhJecaiSzJZtMwNDLTLCdapgdBt3XCL6nEWYpYN8/FC48f6MKzHkykwv8tG5vyxjc9
         nXJCCTA1KCo+SZRXU1xaWYe8lieKE3jGzutvrYFUKJFlZJBMiBrT0Slw5seCLVs52aEO
         7nVLmAvz2KlgA4QaCajkZSkHCX3vubQnRaRBgdXnf5khvq8JXH0Z+aElz+GUufQn+5br
         GB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779289105; x=1779893905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMte6gCl9iyQkJk8kzgWGKq11/9eBOqAPtS55KMlxKE=;
        b=E3Cb+oiKD3NskUe0Q/c9TPLH4KNawrtNSK6PpsecUmSb5ZUvr6aGN5NRqKlOkJZknl
         Z6NbBAKLFmIJmCPpUmDnNf9830WrgpdFE37n3Chcaox7hTvvs7BVzXuqLDYa+DKWxYOF
         wwepvBExuiFJqtQgRngTrNUJRfjkv372pVqKhM6ae72DYVNBeV1rIKOToNVkoxGTZ/JY
         P1nvRTL0W/v3eZrdyn+6mDDCEh8SoD7YCf3XkLDZbff5N7a6UyZgPbuMV8QALVm0M/7D
         367jQ0iEtLD3IudKRxtQchDbWKczXQw8CI3/v7IMRZEt2GmgdhBudY7CWJc9lGOmNVau
         fA7w==
X-Gm-Message-State: AOJu0YxjM2yto5m1SIGnBwZfZlDeO597GxZJc0G7eLy+vPikS2ShZJ6U
	vOMS2b8E6oWdLzQGgQ740NDG50Ia5qhy8MT1/qHXwA5GDBprWEXuK20vc/cNZDtlq5e26YqIjd3
	jHIrOzM7/bxLa78vlf6Cdiil2Kq/mliqvqNiq4Ry1EWZpFqshmtupYY1mv2WqRW1gfoYdDjOSrf
	2w5j1zPw55lef9Ma03DR9/L+pazhVzXZAwdnYK5vOe
X-Gm-Gg: Acq92OHCJQD6UglvXfgDxs4VOaUYJmjbg6/o27C3+0rx6jfWXmwGffDUEkJsD/76FZ1
	AOHVWN/jeJkHOXJNBeAsbsI3bEqhylms2Pn07rukWRZsvwVePGI2jEVpcnxiSnSxj4iZwr9fHMX
	7KQkOJ4H684CJPlBpHKSNPPinRulIMAxF44K+D1ZSVEJAtcK2eQFDrOCPFMRoii4ggCOCeKP26u
	rTmobzxc/38BvV/mRPVmi/gikhjCT83BAyNWRJsgT7eAB79LqrFrEXfbOtCVDslJmIr2AuQ6/0j
	kMVbp0PviXJ3JnHkLidzpGc86yAOaUlsSfHqf8z7tZYbb7LysZbaJotRy1qIuz4Vrjv8y3tOP86
	fcBpdxllGMvf180/wFkqjAWFoltC9vceo0g6qStXOSpFD/67sA6GPQ0ytGTF5HpoZwSgR4opoAF
	HxQIAPjxX4J5aMT585BfI7reL9gAwozy2+Yw==
X-Received: by 2002:a05:6000:2007:b0:43d:67f4:91aa with SMTP id ffacd0b85a97d-45e5c5a5ce8mr36823061f8f.40.1779289105453;
        Wed, 20 May 2026 07:58:25 -0700 (PDT)
X-Received: by 2002:a05:6000:2007:b0:43d:67f4:91aa with SMTP id ffacd0b85a97d-45e5c5a5ce8mr36823016f8f.40.1779289104976;
        Wed, 20 May 2026 07:58:24 -0700 (PDT)
Received: from [10.110.4.204] ([87.215.26.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767d0bsm52916354f8f.3.2026.05.20.07.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:58:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: mlevitsk@redhat.com
Subject: [PATCH kvm-unit-tests 0/5] add minimal tests for 32-bit guests
Date: Wed, 20 May 2026 16:58:18 +0200
Message-ID: <20260520145823.408884-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMX and SVM tests are only running 32-bit guests.  Add a minimal test
that they can at least start a guest with both two-level and PAE
page tables; for VMX only, check also the case where CR3 is bogus
but the PDPTRs are stuffed correctly in the VMCS.

This series might conflict with Sean's regs/backtrace rework, I'll
rebase it as needed.

Paolo

Paolo Bonzini (5):
  vmx: add test for 32-bit guest
  vmx: add test for 32-bit PAE guest
  svm: cleanup regs handling
  svm: add test for 32-bit guest
  svm: add test for 32-bit PAE guest

 x86/svm.c       |   8 ---
 x86/svm.h       |   3 +-
 x86/svm_tests.c | 157 +++++++++++++++++++++++++++++++++++++++-
 x86/vmx_tests.c | 186 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 343 insertions(+), 11 deletions(-)

-- 
2.54.0

