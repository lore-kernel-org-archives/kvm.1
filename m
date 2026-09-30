Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E6734CFAB
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 01:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730738; cv=none; b=TMbHamQV5xE3tVHnBV/jXH+qXbdWVz9e0Q5ZrJ57XvSOc97zOuVJoytGWZmQ8nfZ4eNZ6DiGPuol5tAonLWnkHyWBK54nFNT5a0nEJGLoZbasnDsiiuzZSkEDC3kWFuasvpCfL7RSqivkQWv71Dr1Blf+xAri8fY70Pu2wa+c6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730738; c=relaxed/simple;
	bh=r6QEHOpOYHWj7FufqyeEcfQM5mfa/urPcEzDnrQ04Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3BsE6cv0EJAs9oha/yEhXp8ifLKCi6eU28C7UB2VVyyLoxtk1NwQT/D0YF5D1PQprku90dGvQMMgQr3Js0zqr9Ok+K8XvgsOYcc5X2lm81ObPIpn/6i/vmmTLB1dGv+LsBp38mwbTwm//1OOI++aAbkqT0r4wZxAfHBLsuvQMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=N+EUxWqL; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="N+EUxWqL"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34bb8b31660so680287eec.3
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 18:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790730735; x=1791335535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o/GYHJr9V/8fnSGwEk+BZPbvKDBaM+5fMSFs2YxkmV0=;
        b=N+EUxWqLuu9vcw01cgL5F8i1PXMyFJgmJAVoow9mmlYX9u65gpz8Hu1r9AwpL1Ran2
         cNIc/eWwd8z4U3MBDxdgQECPeSfXC8zq9EfKGWxNUWPJ9sv8ygIoQ8ZKH9adbRsTASPZ
         +XbTa4xpDWUfgKPP+KZK+10DVBhOjdM8aQu3BKUmuQCZ/lLmVFIn8p5oeRVWKrAyVedp
         QJtYVdq2fsInoAlF9E5kDLftJIRaUF5Z6TBVh4ROtxsboYmeNA+ozBYcgM2eOWqbrmlQ
         ZXS8N9Pp2usEGUS1JDEm+LA84VvTfUVK8COpegCXY2+JE1+WxI9up97aIU74Pn0ZbIno
         5u9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790730735; x=1791335535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o/GYHJr9V/8fnSGwEk+BZPbvKDBaM+5fMSFs2YxkmV0=;
        b=WYhmPv7rpnRg3xh/wIx+1hTji0ecvyvW8HEq9ITEV/ConIUkvkTWNxu34A/Y4P+T4y
         stjjJJSCibooyiVcZ1gc6pZeykrvIDHN/Q5fr40WQalF/AxDJ9zy8eIFNMJaTJfuulSu
         doNG15IDXOuknRAMIOhHkPEwL7o7PaXu4RvnIPglH78dOkUfOhAzcNWYZqlHNaWO+lSc
         oCDtGy/CYWGOkNT2XhXPY5MO9dFmY4kfOt3LRSyZELwLMilPKHa4ncICssNsFXxKTVgH
         S5zp/DdpxEjVk6FN13TYjVGKXkn8pqHAWzM24e0mXF2JNNTn8GkKDlGGFDNxL+1B74V3
         YA3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzzkddW4KM4rd5MNlHuZBd7Til7mZe51yVzQyu98Y/vXHvy1FYzLtsfV7Pzq39UZuRyYV0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIfbAXw4o4CHUQB203yB2ZvhD1GPF3aYzOCdchhY/SAsvoxc/J
	hiGFcWd/GKtZo+twyQcOHn9JY0321I5ieDkmbvcBDEFS4nl3dItvSUNMlMkOcZKmNgw=
X-Gm-Gg: AYBFou167Zp8VexI3CQ+1SYVbm6gLr/EAJ/G6r2QiCs2Ib3GIwcEM7am+NbW5XcWjd4
	/vQ3ye6/vvIRqky4IUDxMecfpIbjwAVC1NkE89locVJR2DaIhfIVTwFfrmSy8xQEOlxRVA2oxq2
	//F8/Lu3ibRB7tcLcaXpSlhFucRF/mpPa1cCEcBtOyCa+tKsw4CJfmDSZpSUSBe1p7v0TByW4QT
	NegYT/tjxGtP3wzC2V6OkpT5PiVbMayJteRx8Tc8nN2qvDkgujShhjXvOaDOXhKm6K+52EFdOJu
	OOX8OT6W97/hPvMvxGKhefhyYTDU995SzC9U7zTjWt80YW4UtB1be4pCdaszeo6ouIsc40xJiGn
	QnhJD0ZXsr8Z3Y05/JwAcn7iFhSk2rf0pORTGfJ9/d0ig2J/Ar2+XIF8Q3vuvUBuf8K6JAwscnV
	joCrUQ0dihcECsOTC2DdFaOoTfAc7zCoN14kU6hbWc0Cm7RuAEno9Oq4vVduPw7cxH+O/VKqvYF
	pTufLVyiGha3gFsyVu53ST9MM8rEhmbInJfPv8kPmPMD0aakwW3QY0qq5G+AHO8SEuQonY=
X-Received: by 2002:a05:7301:23af:b0:342:a328:fe1c with SMTP id 5a478bee46e88-34c672e2943mr1274302eec.27.1790730735387;
        Tue, 29 Sep 2026 18:12:15 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34c388f4e19sm2290684eec.22.2026.09.29.18.12.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 18:12:14 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Christoph Schlameuss <schlameuss@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	avi@redhat.com,
	cotte@de.ibm.com,
	david@redhat.com,
	mtosatti@redhat.com
Subject: [PATCH 6.6.y] kvm: s390: Reject memory region operations for ucontrol VMs
Date: Tue, 29 Sep 2026 21:12:08 -0400
Message-ID: <20260930011211.94657-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Schlameuss <schlameuss@linux.ibm.com>

[ Upstream commit 7816e58967d0e6cadce05c8540b47ed027dc2499 ]

This change rejects the KVM_SET_USER_MEMORY_REGION and
KVM_SET_USER_MEMORY_REGION2 ioctls when called on a ucontrol VM.
This is necessary since ucontrol VMs have kvm->arch.gmap set to 0 and
would thus result in a null pointer dereference further in.
Memory management needs to be performed in userspace and using the
ioctls KVM_S390_UCAS_MAP and KVM_S390_UCAS_UNMAP.

Also improve s390 specific documentation for KVM_SET_USER_MEMORY_REGION
and KVM_SET_USER_MEMORY_REGION2.

[ Backport to 6.6.y: omitted KVM_SET_USER_MEMORY_REGION2 documentation
  because that ioctl is absent from 6.6.y. ]

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Fixes: 27e0393f15fc ("KVM: s390: ucontrol: per vcpu address spaces")
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Link: https://lore.kernel.org/r/20240624095902.29375-1-schlameuss@linux.ibm.com
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
[frankja@linux.ibm.com: commit message spelling fix, subject prefix fix]
Message-ID: <20240624095902.29375-1-schlameuss@linux.ibm.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and kvm s390 maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-43819. It rejects memory-region ioctls before a
ucontrol VM can dereference its NULL gmap.

I (sadly) do not have an s390 to run the fix, but it built and the adaptation
makes sense.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-43819
Upstream: 7816e58967d0e6cadce05c8540b47ed027dc2499

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 Documentation/virt/kvm/api.rst | 6 ++++++
 arch/s390/kvm/kvm-s390.c       | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 21a7578142a18b..0f7177c7653bd3 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1363,6 +1363,12 @@ Instead, an abort (data abort if the cause of the page-table update
 was a load or a store, instruction abort if it was an instruction
 fetch) is injected in the guest.
 
+S390:
+^^^^^
+
+Returns -EINVAL if the VM has the KVM_VM_S390_UCONTROL flag set.
+Returns -EINVAL if called on a protected VM.
+
 4.36 KVM_SET_TSS_ADDR
 ---------------------
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index cf075a89342263..97b436ae0012c5 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5769,6 +5769,9 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 {
 	gpa_t size;
 
+	if (kvm_is_ucontrol(kvm))
+		return -EINVAL;
+
 	/* When we are protected, we should not change the memory slots */
 	if (kvm_s390_pv_get_handle(kvm))
 		return -EINVAL;
-- 
2.39.5

