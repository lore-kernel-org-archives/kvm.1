Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A87B39BFFE
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319080; cv=none; b=jwu9F8kBrYKuodn6oj4jKFoxVYGWPsz2Vl3BNutV+41i3Md0Yy0CavafE6zceqeQzSDQYKJp70h9XWUADJ4iILJ02/M3DcyXccyNCYis/k/uVTlLNUU63UdQYIIMsl6DAUjfQ4S7kk/gPFfR4KNJt+z2w75PDSjW9GQ4mIa1AKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319080; c=relaxed/simple;
	bh=MjrYeX3O9nNiiB/MKuXQK9ZharRhOnd3F4rdG5ea7r4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eWskZAve+8XBllW2eEdyIoAxbbKF3FDRggz7uyapaIA0V/l225msNxxsQ7D4grC8ksFz4h0qKEd3E0gSulNRgsuvqxOFl4UoqPm1mOkCwG4kX7JjzMRw7Sg4FDRNYnvX6ZI/9IHqr7egHDjV1f3S47XSDpoU35oa4EFXe7iHUL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFs6TvmA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFs6TvmA"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae505619baso6951065ad.2
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 05:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773319074; x=1773923874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4kpKB82B808dmXk8GsT3FbFqvAl6veGW+hmwY2lKqMA=;
        b=PFs6TvmA99jXuNxEGn/CiQLDjxFQF8Q7zL8mhc3aJA3YCiF3V6PBVp8BkYY0CyDLXj
         Wwy+GgeP2fcissPBtFkA3/NepIECyeBB9dgMUmkcYetJvlo5QG/KGKLcVoBmQPx8l+Fu
         lJhQLSgUOt5lW/ECzeePf7gW20TE+y3qdHVhPY/ofdV9CUiuQJwqw5V+60+TTNsWyJwH
         EGfix2H9FBCxovwseeIP3Ff4wcmeyTv2HNpBzVDwlQnNcSSRqP3yIhksE8h7tr7K4B3P
         prowm4r3oEeouDwkRtT6eajRVohxjhWUoGs37Er2PsXXUrhdSnwOlvTX4Sb5a7Agw/X5
         3wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773319074; x=1773923874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kpKB82B808dmXk8GsT3FbFqvAl6veGW+hmwY2lKqMA=;
        b=oJK7BqGV9U5owIvsH9y/EUzm4EeeCY5EZqXr+zRKUnQVMHRxNEyKNqdpmI+JhwZF6D
         07bP8V6osl5WeweQhUYR8sPR/UhoEQ8D+UNhYztOfdglODBsds5nKBGsnepsGRA+YJ2y
         z1KLKayHJdPZudShXuCd5EFDOHHhW3MM2KQS7warXRYiiA4farOLxBT0mDOJS7D19cHB
         uX0b4G/Kov+3tk+WkBJ48wiwbArLFluwGX29YVHAIEVM7Gqi/Wa4qVmgpb5QsYUjY7va
         Y6evEHSia+QeFVGVPpgrNjXK5Xtckm01EVdbXyFePTHLixDpd+I6JEz+jLLrMJTNf/m4
         3gKg==
X-Forwarded-Encrypted: i=1; AJvYcCXxKwzyptbxY5sjtYgdBkVhxnDtUUuyF9zgi00aqhAbqZlbHio48fDpsuaiGkLeMM03GiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3MbxlPnkw1ipq0EMTUSkjs63Y4J0GuQXppoktsduxizck/sMJ
	dLCRnldsQDk9dT7lNha2vmKiuW4gnr8iz2Ua+M9cGoXQ7eRAr8qRDezo
X-Gm-Gg: ATEYQzxF/8XIp+ptS0LpGwdgcjwT7yyg1MuDv4Nw7fc7q+OJx2x8vBCENT5AkTdu/eb
	gzT00YGWCh8ovV2rErO4FdFnVB1h9JCI7NW2qdJNAVASr/eErbOK2vNkaFinXSLJUvKDuQI0gWQ
	h96ocWn+zMlXIWwxjfwnrGdT1x83Vc2MuTm2NexbEGY78U1QyaoNOMLxsFZi4anI5tcv50CgR1N
	YRB748uZPdYMjk0XZWMX38QftIDIyoTTntgdAwwkpffDuSMbinEO1j2zvoRwLjc0PTQ3bb600EU
	Wpow+uNH1ssUQu80dls9WHLVenxrcv1y8QlBlB8F70vB0nNayDn0x0Knqnn59xQNSmACXrIpmm8
	WhFS5kU0TPMZcWaKBsiKGh7qEkaonurGHT2n1D0a05vHPU9yvH/6j0+06u2ULo3sVRl34eWFbs6
	2tiaoZZ5m6Exqbuo1OToZwZRbiDQt58Eikd+EyKVL3a9ZQBztkDVLQA/MI4PMxZGq969lKf3bLT
	mvUSb1Sng==
X-Received: by 2002:a17:903:17cb:b0:2ae:c529:a130 with SMTP id d9443c01a7336-2aec529a950mr10622195ad.9.1773319073829;
        Thu, 12 Mar 2026 05:37:53 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aec7c81621sm4550265ad.83.2026.03.12.05.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:37:53 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	kvm@vger.kernel.org
Subject: [PATCH] target/i386: Fix dereferencing before null check
Date: Thu, 12 Mar 2026 21:37:44 +0900
Message-ID: <20260312123744.232366-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'sev_common' pointer is dereferenced via SEV_COMMON_GET_CLASS()
before it is checked for NULL.

Fix this by moving the NULL check to the beginning of the function
before any dereferencing occurs.

Resolves: CID 1645467

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 target/i386/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index cddffe0da8..d23694e05b 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2009,11 +2009,10 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 static void sev_handle_reset(Object *obj, ResetType type)
 {
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
-    SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
-
     if (!sev_common) {
         return;
     }
+    SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
 
     if (!runstate_is_running()) {
         return;
-- 
2.43.0

