Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9803CC32E
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787215758; cv=none; b=RqxN2GodGVUqgiARUUcE1nH4HXDk01eTXPej8GPaxAHQj8ebsx8w9EQkTvHcSphsv7KhAoN4Xpgqecv45BYGciw3IdGAiZto5Eukei9uhxrlk8h4U7XQIyIfU0FVBC5T/XITMh/Zf8HfDFpQhjroPdbxbZTzs1dUOace8+iYH+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787215758; c=relaxed/simple;
	bh=IaiDVKm2VKD6iOtitRKVidUAgVYwttbSfVjgHlfvFIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d/25KIJlrhOifJW/lLBOawZHKgtSmpWfYBOaRomoVW+d4t8IeyzAPQ9qT0DCuGkq4rtf1aGWU3kEaRWwmeNaL2iTFDQTK8eOyvvNC4OfBn+yqHLu6OAi6nwPRXgCBZfS/Fdtd6eFMqQI8qctYvM+u1v8Mpsh5MB/zU4nOgzhRMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCMfUc2K; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+nPf5T5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCMfUc2K";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+nPf5T5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787215753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eEOzKnJHG0jcty0bphHUdJTbBxkY3EyBFKtQhjaedWQ=;
	b=WCMfUc2KpZO7H4rj2XuBoq3nPZ8F+5fJM/x/8Y/8U+zIGfF3XEsh3+/fAg4RkqpHsDKOYn
	tl6Pd7RIIy2g+b7o24u9wIMPFTs8TlyQzlb5fUfhYY43NULn5DPoIIdXA4rPdggyT2ntM1
	WwVKibdJRSanUxrhMhjkCtua1Zl9gkk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-LxUEG_O2NaeKwty0np9fSQ-1; Thu, 20 Aug 2026 04:49:12 -0400
X-MC-Unique: LxUEG_O2NaeKwty0np9fSQ-1
X-Mimecast-MFC-AGG-ID: LxUEG_O2NaeKwty0np9fSQ_1787215751
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e25e4b41cso2555042a91.0
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 01:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787215751; x=1787820551; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eEOzKnJHG0jcty0bphHUdJTbBxkY3EyBFKtQhjaedWQ=;
        b=H+nPf5T56P30jQk7EbRwNYlSF9GXJIDmAL3PLU0K9iAmdEt252EkZxS1roePSiWFzF
         NZ1VYkF2P9K25PywcU79ITu7VwNdX109QPFjX6G0QClX+jpnrfb4e1aa5JNWFDH1yXV3
         ssD+Il86bDnF7i50xVm604h8yT3yTkK0kh6Eozj5tzeNYbWkHp+B4O8ojoLln7mFQ6md
         TnxlFN8GeKK0OnFp6Z6UI80K4ncQPJtBsfftm86Mz8jhMI+weZzVcciCdlZkuG6KumPE
         GVMMWswl1rw1gd5f178yPL5cYJaL9Zux7+2yfiOW3r1zpHwhtPHpY/rasM4pI7KEAQWJ
         gkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787215751; x=1787820551;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eEOzKnJHG0jcty0bphHUdJTbBxkY3EyBFKtQhjaedWQ=;
        b=rJEG0Hupfz+y7XOySFoyBwEWxo9bVEap3vnDrru3Rj3Eqm3SBZjVBGGDYhke6q59UL
         Zjvu+t8nbAO8rfBiM3ks8RwBUVAq8U/u1tsYuyyTJXeGW8rz2uAVwISS1FJkzHXHh83Z
         MXs5yQJXpCigIp7MS9sA/sEEuojSG8c7OlpZHS2RrxjBqEXx6PPNmIP/LVQ6XwuxtgTG
         llrwba2G/KJJ3Aj6qws26B1mtawdtP1250Jc7FTGHMzuQWlp/ydQbLB09r/ugx1g0VBy
         gLEFuG8Fj1B163fM7ZUpqBM6PiqSXW9CrHVS5qMpRJw2S4aA4/VN+hUBLK/fLiLxIwtn
         8GIw==
X-Gm-Message-State: AFuF++leFro2I99xDtqou0ewpu5IM2vkRJwIS5ue2KvX0wa2A2HQtmKY
	56lC8KwgOVBn/AwgnUWuca43VidDyrguOlXK/1ljEg+v5jAvAYd2AVys7jXWE/Kll262rs+ix9Y
	urtr/nDozEjR82ZvtIl6bgsBj/n97wQb9HHZUCiYspKaf60EdXOi8YA==
X-Gm-Gg: AR+sD12FwQjk+ru1dOEK8uWN4ZobDoE/uXUy1Qj1q4o/gxSpu0goinaERMXjKMDW6HW
	bB8Ssq/D0hGRfkepUxKqOBO+GHvHK/6+DZMqm2+BT3ydTSalXtGYHjRLYlEX45fsEK1XsauY4FC
	tLcNDBsnnDg6ivbV3xd4Pc/3DrI/ABBg5PFtaT9kJGtOT75/JY/p/qKs3kpyxyMWk6fK8XUlwA9
	JKWwver2KLvza2jjztlw80gODl2QODzMk5BjZaBz7AjYJHLHSiRFctSvr4zQvY/uA4Q8fGdt/Yf
	PbBqO732fr4PHxC/pM064ja0nETmowW5zrmwTp78vAncfEhlC9BP9N4CbHFkXROfK7hVPXgH1Xc
	43+FwRBmGKhQCNItc9PxsSaGAwygRv24=
X-Received: by 2002:a17:90b:2d85:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-3958127ae44mr21316000a91.14.1787215750776;
        Thu, 20 Aug 2026 01:49:10 -0700 (PDT)
X-Received: by 2002:a17:90b:2d85:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-3958127ae44mr21315916a91.14.1787215750277;
        Thu, 20 Aug 2026 01:49:10 -0700 (PDT)
Received: from [192.168.64.4] (fsda291717.tkyc313.ap.nuro.jp. [218.41.23.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad699c9sm15001822c88.8.2026.08.20.01.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:49:09 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Thu, 20 Aug 2026 08:49:03 +0000
Subject: [kvm-unit-tests PATCH v2] svm: Add SMI handler for
 svm_intr_intercept_mix_smi test
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-add_smi_handler-v2-1-80d7316d5dde@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNwQ6CMBBEf4Xs2ZJui9h48j8MIZVW2SDUdAuRE
 P7dBo+TN/NmA/aRPMO12CD6hZjClIM6FdD1dnp5QS5nUFLV0igprHMtj9Rm6N4+Clnrh3aIF6w
 Q8uoT/ZO+h/EOwzKKeaIkkufE0GTeE6cQ1+NwwaP1d6NBravqXJraGIEirpbnMNhb9K63qezCC
 M2+7z+ZIFk3swAAAA==
X-Change-ID: 20260820-add_smi_handler-063b3d117141
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Ryosuke Yasuoka <ryasuoka@redhat.com>, 
 Maxim Levitsky <mlevitsk@redhat.com>
X-Mailer: b4 0.14.3

L1 intercepts L2's SMI and the SMI is still pending at L0. When L1
re-enables GIF via stgi(), L0 delivers the SMI to L1.

If SMBASE has not been relocated and no SMI handler has been installed,
L1 enters SMM and executes garbage at the default entry point, causing
an abort.

Install a trivial SMI handler at the default SMBASE entry point so L1
can return from SMM.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
Changes in v2:
- Update commit messages and comments based on Maxim feedback.
- No code updates
- Link to v1: https://lore.kernel.org/r/20260818133445.8688-1-ryasuoka@redhat.com
---
 x86/svm_tests.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index ccbab1d0..639da786 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -3543,8 +3543,36 @@ static void svm_intr_intercept_mix_smi_guest(struct svm_test *test)
 	report(0, "must not reach here");
 }
 
+#define SMBASE	0x30000
+#define SMBASE_ENTRY	(SMBASE + 0x8000)
+#define RSM_OPCODE	0xaa0f
+
+/*
+ * Install a trivial SMI handler at the default SMBASE entry point as a
+ * fallback for when SMBASE has not been relocated and no SMI handler has
+ * been installed. Without this, entering SMM executes garbage at the
+ * default entry point and aborts.
+ *
+ * If running with a firmware that supports SMM, it will relocate SMBASE
+ * and install its own handler, so the handler installed here will be
+ * safely ignored.
+ *
+ * The default SMBASE (0x30000) region is safe to write to: flat.lds places
+ * all sections starting at 4MB, and the page allocator starts after edata.
+ */
+static void install_smi_handler(void)
+{
+	WRITE_ONCE(*(u16 *)SMBASE_ENTRY, RSM_OPCODE);
+}
+
 static void svm_intr_intercept_mix_smi(void)
 {
+	/*
+	 * L1 intercepts L2's SMI and the SMI is still pending at L0.
+	 * When L1 re-enables GIF via stgi(), L0 delivers the SMI to L1.
+	 */
+	install_smi_handler();
+
 	vmcb_set_intercept(INTERCEPT_SMI);
 	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
 	test_set_guest(svm_intr_intercept_mix_smi_guest);

---
base-commit: 033ab80d18bca31a6e428b877518883c90c3a2aa
change-id: 20260820-add_smi_handler-063b3d117141

Best regards,
-- 
Ryosuke Yasuoka <ryasuoka@redhat.com>

