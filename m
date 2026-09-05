Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F3623D7E3
	for <kvm@vger.kernel.org>; Sat,  5 Sep 2026 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788599361; cv=none; b=CUv5ff0xyoNXvKA1T5wHl/iX/ohFaTxc67M7GFamRahx0OTEgQ8/XucO0EAgLJDk6EJ28MKyAYh0F+HfV5lupTMVaKQbgv9n3Lvcac6B7m9MWA49l3f+7FYvpSPEgrX5s35C/zQEoR0v1ha435H1myIe+XkbGZW4BY8i0PZ3/Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788599361; c=relaxed/simple;
	bh=Ewt1M7+spoIg1ijQPCVTjWY+YS8lJvToT/ZNIgAjn/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uC6pllGZCPMW0ODgR4ZtlXDxRsv6MeRY1fMJwEnnrJa7bGvMZdwUWYUT5ZCapHxBKYxhyh1spfs4cg5q029uNpO27AQtV9IswvxkCP+PzXCKNo1xeVcaqhlDcZzTNDWMkXXhdEX2KY4Ed98wd5dX5GXU1J8wKmJp8aXksBG4JAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJFVq48V; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJFVq48V"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so20934595e9.1
        for <kvm@vger.kernel.org>; Sat, 05 Sep 2026 02:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788599358; x=1789204158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W4LuSu+7CiDy4mVJm5AlYN6tP/b0HvnqAwIEQlMsVOU=;
        b=fJFVq48Vs9mF4x48qlxw8Ab4r+h20Mz+tbzFUoacGPBBgjOhkJd4N+CwinaszaktFT
         KO1CnP1zcRjqBwHEwhasaEq8h1eCKZPY7yO1faAElaWEHE4ZyeWaNGddMhhTsUAeGD22
         WUL1CXH6Xl/53+g4QT/R8jXpRTCWCt8g8+ZV4BPXePfJOsFQ3qPWn2yRGNiqZboMxiA+
         aPTK6zPnwdt5BINgThJyBCm7ylrCPZPpzn1+AyTDXIZsexYj34PqOxur4LGye8uGBHn7
         FUixleyffUbe8NUn1PntDBgRj0dXhuFPcKhHMwPoLFNKojw786h8ytuq1u2syxtIIP7F
         3VWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788599358; x=1789204158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W4LuSu+7CiDy4mVJm5AlYN6tP/b0HvnqAwIEQlMsVOU=;
        b=F83sGoWz4JhfYVDxALDqkc3lCtZhiCuKcysfkB/RtI84AIuhbNUq8UJuOkvVzkEqyM
         Vr81RVcuWo9gunxY/mI9c4VojQRRclak/a2LdfbISFiuwxaljlmpWoxXrggJ2x3Z0BJ4
         lJmf6LyGiTwkQJWNHYZ/kaUQh56el9TxYyeT4/IQppYLsaJPokJE34scQtFR0GAp3+Xy
         aX+6LKrBpZZmhztWsZ/DjtGaSRBnQMnfpB8NqYEFBGtukTNA5I3pMrp8m5xBHxUdMENK
         HcYB7Ymtom1nf3/tmdT7HB1dM7UtJM2MLSGFmqbofc0hhspEz5OnxbaLPwKLbAhE+k9I
         xX2A==
X-Forwarded-Encrypted: i=1; AKwUvByQyyqvKuHC9pNNyND50rKP8wbMtI5h+Wbmg1nDBasSzkDb4P/v9bhDT7kPa/XNyHKqoD4=@vger.kernel.org
X-Gm-Message-State: AFuF++kxfWka/awWceqBfX3UvgSdQ0hpFAJm2xfROMHPu/jZOEiFT/f7
	OBD7WEC5vfh5uuKtpSGklVVS1sUpUZIczxleP1x8LC/rnvZh5uMc0r3z
X-Gm-Gg: AYBFou2f/FD4ss7n6hOsyQnY5vXV1s33iVlUQ5y/naxcxHEz8kmCBUtm7IHWrdGcUjU
	2KTi5XW0r602IqiAH64fjC9+P9H2BOxrqjD5sNR+RCBsYSxXaxsUgbG4obGqCV0g2LHOBwCgy5B
	KMpd2PB+TrhvYbSoa0rpU8DrIQo5xEkuk6oJ82MGr3ZI8j4JOFoBabI9kcoNrTqFT1K0lObPqe2
	Jot6a7GysDKUFWQNnmEOngMGAdLZYc1TzyL1LMRp6u0DpkY3A0HMxp1vzqMqUjVbnOhVlZF6IUR
	SpT/U14BHHqh6mPSAVp2XEOOK/IhAbb6FlJY/SjkAh8EjPLqgGJRSW1FotM6QwAYtMPabG8rdQT
	SW7WkdR+QSJivzUNX7OSW2OOZV/4kJJcQH4KCY3WydxM79ON4NpLebW63Xa/ggFivc9f/JkXaUf
	p59nIrRpt0q/JP2px40950o7imWfne1Tz0rbQdha0HMoj3mbpsx4KCvugKvEmKy4xdzl/UdNKgN
	cfRpKtlJby5egtPJJ5H0gRd4X4Ipl+lZmiNPqKKaVHw24hBOie0+NpZKrsQq3IeI0W//Xapu2re
	xfbx4vEowzOur/0qG58CSB60vvoGYW8Xm+znt6hm62mVL4iK4apT9IkHyYSHLvPlAVNp9iELXr0
	45A==
X-Received: by 2002:a05:600c:190b:b0:49c:fc6c:be12 with SMTP id 5b1f17b1804b1-49cfc6cc0acmr75745675e9.24.1788599357697;
        Sat, 05 Sep 2026 02:09:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce55259ecsm195482965e9.2.2026.09.05.02.09.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:09:17 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH] Documentation: KVM: SEV: Use the uapi structure names
Date: Sat,  5 Sep 2026 11:09:12 +0200
Message-Id: <20260905090912.40740-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The document names struct kvm_sev_launch_update,
struct kvm_sev_attestation, struct kvm_sev_launch_send_update_data and
struct kvm_sev_launch_receive_update_data. None of them exists in
arch/x86/include/uapi/asm/kvm.h; the structures are
kvm_sev_launch_update_data, kvm_sev_attestation_report,
kvm_sev_send_update_data and kvm_sev_receive_update_data.

Use the uapi names.

Fixes: dc48bae01e5a ("KVM: Define SEV key management command id")
Fixes: 2c07ded06427 ("KVM/SVM: add support for SEV attestation command")
Fixes: d3d1af85e2c7 ("KVM: SVM: Add KVM_SEND_UPDATE_DATA command")
Fixes: 15fb7de1a7f5 ("KVM: SVM: Add KVM_SEV_RECEIVE_UPDATE_DATA command")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/virt/kvm/x86/amd-memory-encryption.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/x86/amd-memory-encryption.rst b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
index bd04a908a8db..9ebd99aa1d0b 100644
--- a/Documentation/virt/kvm/x86/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
@@ -170,7 +170,7 @@ Returns: 0 on success, -negative on error
 
 ::
 
-        struct kvm_sev_launch_update {
+        struct kvm_sev_launch_update_data {
                 __u64 uaddr;    /* userspace address to be encrypted (must be 16-byte aligned) */
                 __u32 len;      /* length of the data to be encrypted (must be 16-byte aligned) */
         };
@@ -316,7 +316,7 @@ used by the guest owner with the KVM_SEV_LAUNCH_MEASURE.
 If len is zero on entry, the measurement blob length is written to len and
 uaddr is unused.
 
-Parameters (in): struct kvm_sev_attestation
+Parameters (in): struct kvm_sev_attestation_report
 
 Returns: 0 on success, -negative on error
 
@@ -377,7 +377,7 @@ Returns: 0 on success, -negative on error
 
 ::
 
-        struct kvm_sev_launch_send_update_data {
+        struct kvm_sev_send_update_data {
                 __u64 hdr_uaddr;        /* userspace address containing the packet header */
                 __u32 hdr_len;
 
@@ -447,7 +447,7 @@ Returns: 0 on success, -negative on error
 
 ::
 
-        struct kvm_sev_launch_receive_update_data {
+        struct kvm_sev_receive_update_data {
                 __u64 hdr_uaddr;        /* userspace address containing the packet header */
                 __u32 hdr_len;
 
-- 
2.53.0

