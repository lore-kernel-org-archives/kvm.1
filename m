Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B403830DEBD
	for <kvm@vger.kernel.org>; Wed, 18 Feb 2026 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771415001; cv=none; b=L40DD0H4TWD63cErYXtmWMOcAlYR+jkWi5UkZNkwtQwBcNyM3yUUB6acnlKlbgJDcoO5xK4nsN+ibjYEU6F3RmVFeHzfVO/M7A7yhl1+mMZX1QLvrVsmN/mFTJRpofr38+vM8UBi+JFrJQlQl5n5zZmbYL7g+VfwzRiFWf8+l98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771415001; c=relaxed/simple;
	bh=/PuBF3v7rt56A5A9Yjsfwt+p2CZx5M5G9E9m4MAs3VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJ+LOC/FIFDEN0zMW8jjvx2lrWRD5y92PkmNeHVE+hAHDBZAxBJdmSv1e+X2Z/3wSe+nYsbeCBfpEA2BG3L+q2NOt9UImJvZRtAd7z6ftm2E0ViwjANmFIxcJmuEdvGlXerhJetaXG/Yb1VpEUaJoLh+FWn0mfgS6LQ/H3nMwxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MESxCZ1T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ObqiBxvj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MESxCZ1T";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObqiBxvj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771414998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPmsaquE3JdAXLnO3ruw5k4aSto0QbPW72QvF6hvRt4=;
	b=MESxCZ1TuMPBD9Ynebsma52evy81i8wVWmbgPvQtnpefKeKrf5EtoccI9jvbiZ1kiZ6qsA
	pHnkQ8tiya38SSUdlFUvtULcpGKHOd/qvJRGw2AZOla6Gin6osKbvCZ7UvFA8ORphiQ9SJ
	NANkh3Idc+AL1rAnCq2egMlP21UhCmM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-9Kh16AU8OluyZAhWSvVhtQ-1; Wed, 18 Feb 2026 06:43:17 -0500
X-MC-Unique: 9Kh16AU8OluyZAhWSvVhtQ-1
X-Mimecast-MFC-AGG-ID: 9Kh16AU8OluyZAhWSvVhtQ_1771414996
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a77040ede0so56798145ad.2
        for <kvm@vger.kernel.org>; Wed, 18 Feb 2026 03:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771414996; x=1772019796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPmsaquE3JdAXLnO3ruw5k4aSto0QbPW72QvF6hvRt4=;
        b=ObqiBxvjRsjrPPjONcvmyaQbErphnQpA3zZnqL2GQld7/8LLLLtbhhWuYCRXFemDJ/
         HN/f4RnfzaVlMBYMS8uhhc+W0H8GbJe8JFB1GKGUz9cFHT0jz7CYN88Rf4Wa63oqGQQy
         01ZRbnKzK6FikElGf7aYZCrJV/7tPUgNezMxYHx8uK+cL4zy17dorAu83aew6cqO/jHg
         v7NSEOF4AcRPJIiv7jxiw310SHfcIcfoeeVWH6KPj2jAK6kQhLknzFcT6aFb/f61IuX7
         w37pBi+0Ve9IkddeNl3QSUhfsqesamwOake5GIx4OOQj9ytrSQJhBJlEMM3ccBLc/BYB
         mAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771414996; x=1772019796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oPmsaquE3JdAXLnO3ruw5k4aSto0QbPW72QvF6hvRt4=;
        b=HwDFfiUNiaXcckY+e2STy7YbGcapI8pVcVwOoejyIvkN53jE6bkx4h02ZoFNVpSX/o
         xnP2hKBMa6O7mGxrLthLojGhFnVu1Kaeo2BUFjns/IUVqneV/AcEGqO4KudtWNSYZPJ1
         McIVeQn3iTnamaUK4MtV1n7JXUSJrN7EPBximJ+qriRgJA+Pw35lT+ClOERiQAJ8SaDH
         UwzWnziXL3lKpElpfT18+k2P4wWC2U/eR/5pO4GJR20IyDVfe9dFx4Ku3xsrPsHQjV/T
         6oUNfK9uEJ1J+CMpddt/WdmCqoKGkMzo93TDoXxKiBLqYM67zOZdxbWTkL30rF4YKm1U
         zkyw==
X-Forwarded-Encrypted: i=1; AJvYcCWYdyIdY0+njVgbvuC6V77fg+kL7MKoW9xN5C243hTNFs0qNgHlcXceMyM82Ef6WTDmC4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxVtIc6EpKg+s1As4qA3QxBSdAnAsnO/MpF6ghOg3k/IQVRAGj
	aoUQpA6PdugiI4KZt+mg0XvnGSol3OWys21ng4vWhDIwq0BMnaHgA+Gna7h1q8XOOZ/ZBa2qgoF
	2XanLTdoVGKXgxm2OPhuWO8+ISt6hXpSnCxHg8datsLW6ikrOHHL8jQ==
X-Gm-Gg: AZuq6aL+hixFWeB0L5WhPsEBXd3xsbAYbsFE0Hxgegd0pivsY+pONp+8iHuJ4aHvEcR
	/3QMR635WTLmG05bKNczTGPmX9Uo+IlF4LoyFf65RxAHj2z4ixorMzX0JF4nrGAskVLAFtHHnJo
	d52a5vHDbRSIUpUrOeAeDND8AUmliKJGfuZ2hQAm+deFGbaS6yv8eDmSC+hRP8NJqJhVEVd7Zyk
	INM4oYDaiLUrEq9tI1NamgotOsJu1RN+0xz8tt0s6S7hXr8CxrjwojBcsBvlWPfs1rHpKJUNtyq
	i1fXYlvfUJHCD/fvXoINj64ssjdMJpzajHpQxbC8fZmuuHUNo9gfhmY5HfGRwG55OG1dZbR+5qy
	pvTVSRc844KMvIcXSTxnH1wT3xvg2lhLy18UdyKW95gpfsNobMTSB
X-Received: by 2002:a17:902:d50a:b0:2a9:cb10:42d with SMTP id d9443c01a7336-2ad51004771mr16038165ad.61.1771414996572;
        Wed, 18 Feb 2026 03:43:16 -0800 (PST)
X-Received: by 2002:a17:902:d50a:b0:2a9:cb10:42d with SMTP id d9443c01a7336-2ad51004771mr16037995ad.61.1771414996169;
        Wed, 18 Feb 2026 03:43:16 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 03:43:15 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	kraxel@redhat.com,
	kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v5 10/34] i386/kvm: refactor xen init into a new function
Date: Wed, 18 Feb 2026 17:12:03 +0530
Message-ID: <20260218114233.266178-11-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cosmetic - no new functionality added. Xen initialisation code is refactored
into its own function.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 8679e7d3fa..feb3f3cf3c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3433,6 +3433,24 @@ bool kvm_arch_supports_vmfd_change(void)
     return true;
 }
 
+static int xen_init(MachineState *ms, KVMState *s)
+{
+#ifdef CONFIG_XEN_EMU
+    int ret = 0;
+    if (!object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE)) {
+        error_report("kvm: Xen support only available in PC machine");
+        return -ENOTSUP;
+    }
+    /* hyperv_enabled() doesn't work yet. */
+    uint32_t msr = XEN_HYPERCALL_MSR;
+    ret = kvm_xen_init(s, msr);
+    return ret;
+#else
+    error_report("kvm: Xen support not enabled in qemu");
+    return -ENOTSUP;
+#endif
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     int ret;
@@ -3467,21 +3485,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     if (s->xen_version) {
-#ifdef CONFIG_XEN_EMU
-        if (!object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE)) {
-            error_report("kvm: Xen support only available in PC machine");
-            return -ENOTSUP;
-        }
-        /* hyperv_enabled() doesn't work yet. */
-        uint32_t msr = XEN_HYPERCALL_MSR;
-        ret = kvm_xen_init(s, msr);
+        ret = xen_init(ms, s);
         if (ret < 0) {
             return ret;
         }
-#else
-        error_report("kvm: Xen support not enabled in qemu");
-        return -ENOTSUP;
-#endif
     }
 
     ret = kvm_get_supported_msrs(s);
-- 
2.42.0

