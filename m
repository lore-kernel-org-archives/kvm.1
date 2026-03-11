Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039140DFB1
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 03:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773200885; cv=none; b=MdD6/yPYbU6QuTVPbwjDSVSyZsfJCQtGa7QeqydcQ9Qj3qRkjV5T2dhgm1Kc0k9oiy4NkKttOfrIF66zN0dOi86Bc8U6Y3zJpaLit7ZGlnICnyTcBwwSpybGewmV4/GO1G1iBt01ZsC8+fFT0pB7EUyFW0ph1I7sc6o/kLOFFhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773200885; c=relaxed/simple;
	bh=61Es3JhmMi9pg7sw1TbpcO+5S9c+ufrqYZF4iU04SgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AWZI/ycQ9GPtfk0r4lWLUsTdtuhvjvEfH5pKSeRY1tiqfX+ZmSMBFMdf17cHsWn/H7GEExxUeO4xwwTytuykw3eEEwMV7EbHAQ6U69cGFM5CPoyUAXcOXmIFVLi/2SFKSgi0IvCO5UnVwRS09DD6zG4gkYJlDaDiqKjXNRqTTWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9iQSJpD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBrZswCm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9iQSJpD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBrZswCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773200882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aF2u6GllzhNzrdWPAaFPtE+a3uz91CYpR9l7tdV1HgE=;
	b=G9iQSJpDPOFowxhiWarAtyw81YY4zEhoMlfu6RSw+Fe/2F1j1LmK9Qq64r1UTyHUleGvK2
	nxxnAWsFy/NZdU+T0/dGXYgW+LuKfWXFyrMLvSl5p5yQBQgQxdvvN3Bf4OVjy0WqwiD/54
	kZlp4gN6aPZMwjy3sz1kyUfLGS7veyo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-FnN3aesuPmSDRCHlksTDXw-1; Tue, 10 Mar 2026 23:47:59 -0400
X-MC-Unique: FnN3aesuPmSDRCHlksTDXw-1
X-Mimecast-MFC-AGG-ID: FnN3aesuPmSDRCHlksTDXw_1773200879
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-354c44bf176so13083939a91.0
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 20:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773200878; x=1773805678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aF2u6GllzhNzrdWPAaFPtE+a3uz91CYpR9l7tdV1HgE=;
        b=fBrZswCmWvnui3Vow9JhL6HDylsorWGYLrXWTuXDuNoWSmD1xiES0z/AFWAaPq6BoB
         ZSjCg3eAJVg3y/ljsmLZpaA9d5IQIry0VtkaS6REJj79M7ogYjCnInGmf7RW5BzBu68m
         mZk9QHhh0yeWGCq+JCdnIe/upDcaGohef+2SK223N4DhU0yrPByVdzmSUJToxW50GHHI
         GiN8W2KfwI2xJimcqSch5Cf9YxtCTzvPGXOLxsd/QLA122/6N9AqnGUabeqnGCnEFkcY
         ARZas+a1S3ZC33q6za9Z95F/551EESnRrZtwCpOi200pmOPEgP71N+Ch4rNVOjLF1+Et
         qD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773200878; x=1773805678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF2u6GllzhNzrdWPAaFPtE+a3uz91CYpR9l7tdV1HgE=;
        b=HRllzJvbI+Cq5xojyF0ua++rJDLf+GhJtNyw/szerVWVDfddwoNW6jFbY8BT/3TMnt
         5e4+BRV5HafrmbYXS7WB1psl5cAdwPEhTzri4Ygo5fTsMTAmCcslboVGEBY8Try9ev1z
         HH032HNDqKPVO0XjeMYHqTteuDedbiBQSn8TP15OfgSlKz+2RrTihQYOq1PRmhNkLrJK
         z8/xhRacSqYK3VccuJ7eLQTUo81kh1GGKip7p8xlfwX93dbbUdb9UQWE/8WxwsSlKC60
         2jvJDkQ0sYgfR7uEPVYheYrWXmYDqSQXJ/mUreC5xqe5J4+cZ3Xu9pKlM72mBPJWxcIV
         XnuA==
X-Forwarded-Encrypted: i=1; AJvYcCUh49nC4q+GPq9ZqjrnVnsGZXTTOu10MpvuPnxGxQh84yo8+W+jrqkHcA7A0V30RSV2a2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6NQbTHBg0bSQ7heIbCR95DmM2DnZ5u/ccrGejXGGCE+V8QAw9
	1GI8GaefXdMYl0F/vUA/vb1AYI8xzH2jTq2nIEiXCKkD0PI68ZVyGnieMXokbUuHK2EWwQ4cWdY
	yiQjPzGXgPpwljCYjQ8vsKcLz2Vajv82kLiDtuZXm3NWbAVc5XAYItQ==
X-Gm-Gg: ATEYQzy+EtGAeSWqvO02iXAEOxdOk34a2hPp8wSTikaGwOyEw8elKdWOGZKFiBOjhJ1
	wZpnRAkBYUv1Tcq489NW6BSs892DGee7YjmqdSvDKMagZdyqznmE1mvAnQkZTEDDkz60IEcRIWb
	iHuc0Wd8VO9HiY91wgJHmQ1ani/1p3+aMWa++0VQJOoDJctoVpCe5++wrzzDR+R05wztHOs6jxW
	ZM6NQH8liAkjLxEKsOTbsIE4KWh9YwZ0Cz3eXuaiprP5n7TmK2ckgKfvvt9FvXCC885yFyWxoFG
	+o97Y3fVEEhBwjjPOWrRKIIGJNJkqqmunBcs/2aBb0qkoJSxzh6ALwHLcTAegyVe2r8D5DkXEW2
	A7aK+5VQP5kY9CWIaoSAEHSQBmlWOTY9iZplDkgFIo3oEzRpDl3bXKRA=
X-Received: by 2002:a17:90b:5486:b0:34c:fe57:278c with SMTP id 98e67ed59e1d1-35a01381399mr1169949a91.34.1773200878511;
        Tue, 10 Mar 2026 20:47:58 -0700 (PDT)
X-Received: by 2002:a17:90b:5486:b0:34c:fe57:278c with SMTP id 98e67ed59e1d1-35a01381399mr1169921a91.34.1773200878056;
        Tue, 10 Mar 2026 20:47:58 -0700 (PDT)
Received: from rhel9-box.lan ([122.176.129.56])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c73cdfa9acbsm603530a12.32.2026.03.10.20.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 20:47:57 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH] coverity: fix coverity issues related to confidential guest reset
Date: Wed, 11 Mar 2026 09:16:53 +0530
Message-ID: <20260311034653.59826-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issues reported by Peter.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 system/runstate.c | 5 ++++-
 target/i386/sev.c | 4 ----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/system/runstate.c b/system/runstate.c
index eca722b43c..ca6730d111 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -512,9 +512,12 @@ void qemu_system_reset(ShutdownCause reason)
     ResetType type;
     AccelClass *ac = ACCEL_GET_CLASS(current_accel());
     bool guest_state_rebuilt = false;
+    bool force_vmfd_change = false;
     int ret;
 
     mc = current_machine ? MACHINE_GET_CLASS(current_machine) : NULL;
+    force_vmfd_change = current_machine ?
+        current_machine->new_accel_vmfd_on_reset : false;
 
     cpu_synchronize_all_states();
 
@@ -528,7 +531,7 @@ void qemu_system_reset(ShutdownCause reason)
 
     if ((reason == SHUTDOWN_CAUSE_GUEST_RESET ||
          reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET) &&
-        (current_machine->new_accel_vmfd_on_reset || !cpus_are_resettable())) {
+        (force_vmfd_change || !cpus_are_resettable())) {
         if (ac->rebuild_guest) {
             ret = ac->rebuild_guest(current_machine);
             if (ret < 0) {
diff --git a/target/i386/sev.c b/target/i386/sev.c
index cddffe0da8..9dde972c11 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2011,10 +2011,6 @@ static void sev_handle_reset(Object *obj, ResetType type)
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
 
-    if (!sev_common) {
-        return;
-    }
-
     if (!runstate_is_running()) {
         return;
     }
-- 
2.42.0

