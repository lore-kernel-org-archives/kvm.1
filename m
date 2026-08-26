Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C363F7AA9
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745584; cv=none; b=qaL6qXiOK/rsfsWp+aJe+2HUO7lB3wax6PlaFPYWCbQe1telu29MZUU82Q9yfe6z5lYDGNmFl4yyQO5XHEoz5JGbSWnVhbTzGfyk18h57BlmFSX+ewrcoL5qrUl2ECntHrPVSTmQ4PYATnB7wi6adiFXlNaEYVjEhO817+aF+nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745584; c=relaxed/simple;
	bh=M7+C+WJ6TI3LlJz4XmPvw5Lvngo1jKh4HAhbCTl2ZN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCNo4kOsrjmzkt1WJZYWPcr0Y0tH1E3kVD85dsk9RDu/jPL0wpOd2TAmI3T9ZPKc+8xDizJdJMb+NNZoC3Yf+jd9zEe0ZWlcThOIgrUohjbflGvhkmTg+SObeJjRLhY2XTbrGsOqGPLYTEGbW4OQihSAY1PcpRU3zbf94ix7520=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/yA06V2; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/yA06V2"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb34c17b96so868227a34.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 04:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787745581; x=1788350381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nAOFav5cyT0xrih7PqytNwDZmryC0k3HvKGBgMhuzW0=;
        b=R/yA06V2XrAawFqLDWgfpmqhV2RtAKr9YpaKC173UHshgZ7pMxFz99yCInJt2uNLod
         Yuj6Q5vX8P7+soI/VvdhSGT3KuPcZ5hj3JTlfTphpsrkAF0s7/Ra925AuROHil5GkfSp
         9nwf5bTSVQ1ZIHTtmVq1jHLpzG5QRkpJsJtmoqtMdkwzJmTMXV7V5iri6OS6CBhSWhSq
         Oj04YVbAMcpuJ4kNISAI5IZboe02MOasvF1CZqHhAMvwi1wOGm5gjnbhIrcOd8acsoXh
         QkXu3TGAWih/P8f4UO44Hv2CDXnmHYdOWbHL9ZNajPI3VLT+ChNSRV6x3b5oRvvmlyKa
         HnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787745581; x=1788350381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nAOFav5cyT0xrih7PqytNwDZmryC0k3HvKGBgMhuzW0=;
        b=HFFmkcRIewyDADx3MWnvh5t/WeFvDGnKOy+5HHAzm4mKp1ZJw4Ci+RbVZDXK6IH19w
         TdggGSA5OkPWyxSh7cwDKvY6yx/wyvTqjg3K2HcFo8rjlvOMGccwG81Q0HB2QTItPsf6
         ljkgt/z/SvFCEBvvoEAcFobAHKp6zDNiAb7gCp2kpuES9wwhaPNCLBcXrt84T5Uy8DMH
         Yu/tQ95iAEraYww9ri/2jjPqqwEYRo/L2KQc+3qqtAbzHJ7xi2ZVk3ud2XbMxQzrtKT7
         dtHaU5ex1NoG2KbftFmMZMWhzHZ3y34sq3Kb5/KIoEidM74ddGXS+1khgIDLKolAVNmz
         GwfQ==
X-Gm-Message-State: AFuF++k4pj3iD0K8+bkHR29abUDydxjkaG2a3PjaldTzJBCcbPH4l+p3
	kug4xi2P4Ii0e7KwBw/PHDV+ZW7RghGhWpzwHS+4LO3A3Dm1uVIRbgoo
X-Gm-Gg: AR+sD11QBWOlZ8pAOLjvjqq5Z94TZaIb8yXRjNxlYOaCR69s/EIqoOhXSICSVDShwI7
	sB8RIgctxuwEvWSeAm2xdSoHzjNV0sTSwNByFmsmlmoi/IsMDyYsz8YbJd9wEaCY8WQ9G1abcyO
	sVUQwFHz3EDQgoqD5b2lnwmnrhqBCnZ/+QaDdwkhujlJzHsbLPwhm/PY24FoTylQ7dYdZ4ah3DN
	4vSe5l1mWO+P0FsYjxEAu3p9Tgvd4nOk1YhSBi8uaVR8CYzbGfLmBu3tlO3Wt4lUklR5MUQrM5S
	YxErvqEH5iSxFqSwUUHd0g6jafG3S7Qoy9FuD9cYCVsSB4jJW7fSWmotJoqAuzSk0744K4nftNy
	et6niye1EzTDdMOzfOzatJMvYiSUhIXWKLUD5xx250iAtiFpcCZ+qZsqvfdzwoSOo/EggvIy1Zc
	r0m7rkDITGjkA/GoilhledCe8j3nrkiIdmq6ZlesFUbBXOulXwjUUvjCuLFicXvBwdDbiOaVClY
	c2I6Qi5hrQ=
X-Received: by 2002:a05:6820:83c2:10b0:6b1:4061:4193 with SMTP id 006d021491bc7-6b1a01f68a6mr4659280eaf.0.1787745581617;
        Wed, 26 Aug 2026 04:59:41 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eefd98sm14607883c88.3.2026.08.26.04.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 04:59:41 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] KVM: selftests: Add a helper to read a vCPU's APIC ID
Date: Wed, 26 Aug 2026 17:29:14 +0530
Message-ID: <20260826115915.2882221-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260826115915.2882221-1-hemanth.selam@gmail.com>
References: <20260826115915.2882221-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reading a vCPU's APIC ID from the host means open coding KVM_GET_LAPIC and
picking the field out of the register block, which several tests already
do.  Add a helper next to the other APIC definitions so that a test that
needs to target a vCPU, e.g. to send it an IPI, can just ask for its ID.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/testing/selftests/kvm/include/x86/apic.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/apic.h b/tools/testing/selftests/kvm/include/x86/apic.h
index 31887bdc3d6c..293044c81228 100644
--- a/tools/testing/selftests/kvm/include/x86/apic.h
+++ b/tools/testing/selftests/kvm/include/x86/apic.h
@@ -79,6 +79,15 @@ void apic_disable(void);
 void xapic_enable(void);
 void x2apic_enable(void);
 
+/* Reads the APIC ID of a vCPU from the host, e.g. to target an IPI at it. */
+static inline u32 vcpu_get_apic_id(struct kvm_vcpu *vcpu)
+{
+	struct kvm_lapic_state lapic;
+
+	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &lapic);
+	return GET_APIC_ID_FIELD(*(u32 *)&lapic.regs[APIC_ID]);
+}
+
 static inline u32 get_bsp_flag(void)
 {
 	return rdmsr(MSR_IA32_APICBASE) & MSR_IA32_APICBASE_BSP;
-- 
2.43.7

