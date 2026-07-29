Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84543D093E
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785365415; cv=none; b=W0yMH69uPvlkGkfXVHuYngNUHtxeYynQYrYMFCldVqSGqqL0128zABCGnRYqj08jxaTS5LNcAL5dYzBLsxEpIYOJdK2gJAbidXJHEnLD5QWPVoFbuupUJnBwXZ+4hQ2pH4nZf6/8YFUsvcMBAc9xtU283jxRYPhxYh65+wIAGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785365415; c=relaxed/simple;
	bh=RMkUPqdU/YmdQZQATNbtW5NBA3Vvme4PzsNPipjmf+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ded3aSKQclj3OeMYBNxte8l0ZhUIOUdyZ6+FfDJTPVOgzDeS4Po7gbquvJJERJgv+6xhskbV95LiTr+TiqkSH+8OrDDpLqTxz+8+7UdnMKfIknuU3W69XY3awsl2PlcF0jMfv+ubJ5teEZb2rxpbNyJlWTQNwll2xC4UESNiiWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLTfwKUX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eC+J+sKe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLTfwKUX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eC+J+sKe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785365412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+redXxno3yhMsd+5uVnvErOalNBKKTe/Z8HP7r/UEyc=;
	b=DLTfwKUXUuSs7emowGsy3tsy6H5IbBba6DkoosTPL+xg1IIMzXxfpkazF37Yj498ljRHLk
	lXiaX16Irn7ynbGb9UPLVd0jOH1kn/esregRr+XVMcnI3VfZxzX9CVlmXEUeAlxwLG/Z2Q
	9m22qFzsvFkjVVf65P1uGMOPrjV1Gbw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-FH6_M51kPlqz6Aki3qoOfQ-1; Wed, 29 Jul 2026 18:50:11 -0400
X-MC-Unique: FH6_M51kPlqz6Aki3qoOfQ-1
X-Mimecast-MFC-AGG-ID: FH6_M51kPlqz6Aki3qoOfQ_1785365410
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47407691804so1017447f8f.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 15:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785365410; x=1785970210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+redXxno3yhMsd+5uVnvErOalNBKKTe/Z8HP7r/UEyc=;
        b=eC+J+sKeJBJPdrMfSrUZznnJo2wC69OfLMtfFONf3JjKJ2V2MyGNqeQKeHveh+CBdK
         0Uba7OiVIMMDmQgIHDMJOmvIM/n/a0ddWj4rwPEGExwnXei1YUyXIOdGF/vdlgbsI2pk
         QqPQcLsoA1uASlKvDu8+49UPO7IqeyQj3rb0NfZaVyH12VMYLkWL7WQERN2YNxACrd8m
         MXq/ME6RhmeGMC6GLtIfAgKy6ekDxyy7VU0EvCSntcRyGW7EMHiOpsQraSWll+BV8Obb
         bn9Ra69S/oojyc06m0wlU8JWrjdpyMmwt9WzQ9BkAiGgYALaxl9xTUJ6XczR5fgjubXO
         zYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785365410; x=1785970210;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+redXxno3yhMsd+5uVnvErOalNBKKTe/Z8HP7r/UEyc=;
        b=q3yo4S+bVfh99Icvks4QW+T9EuUSE80cjc5FV+5L37pb5KMRqYC55wMV/5jdjwVbiq
         hw5yGRSHLC1crkBSSV1NIuM45yDbDWB7tsGpbcWrBD6afd5WPJqaMJOZVjIgsce+tEq9
         2u4mRu8Tx4S+prZSg5X7Spuv+rNec6ttQ+07aoxcX4ccFzLoK7zptm0OxpAPC4QbbjAs
         7in1+9y5hZ1q1uCDwMyApampT4fDGzNGQoWzaIAyL5XcoQTFgNhfJFnk7AbuhOHO/+yR
         qiD+3eeCS89WvCQOnKaKlTbg3mENffuXEI4QWVcM4EJ+VzPOnhnaCuIeXKlyLrg7iGrV
         s9VQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro5hthEmOQTcWdLzei0lNhKtE7Mp8gRsMdQ5lBrsD9mhGrjqQdFZFHKuoxE1ucwPbnQIIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlrsg+/tP3enj7kF+PCmN52WPDFxulOog+AXRv5cV5Y7COrmUT
	GCny3l20A4DyNka5IDYSG1T5bwziUP16B9OxQUJninRWwPnFw/gisN3T022z7RIW5n0vbjiD5L7
	+pgqoUaRWxKahCuJLzpORKFhPs77I5YmUVUDA0v3H7Y+dLv+lnxd7Ig==
X-Gm-Gg: AR+sD10ofQ53ayH7lCDRJOFQUQwoK3zEwk5JsX023f79u1xs4sBnLOOaX1qZw9dWXz1
	Ao3H+uGBjAOo0UYv75C7FzUeF2r69LCyXhRG8H/r/KLL5tUSBPQT0yQnzHbBHo1HBm8pHOI6ieO
	O4Z+lAJKTsJa51wKiv7rmdzXFWmv/L0ndc9S5PRPWsOVC97wMIU9gEiSwnwPAnSxi1TTVXsWeXQ
	bYMc6ap8zzMd54AJYB2c06n34rvApIi4sOD6Pc/YK7ThNnzKHk49Mc3xmd5Puh82ei8UJ7jXsuf
	KWrFmjxGp8TPqFu6eMslL+lwQtm9vxfCFMu+U8mzchXQ7gmj95+s5UEulPx430gZ/BnAYHR6m5K
	HKHT5SEN5zI9B7SQ0aElCA88IRS/F+cHoaYNMEO/4Lk5IG3/1UE6eXoUHDLLR//AbxTI7YzcS5A
	brxTo=
X-Received: by 2002:a05:6000:60c:b0:47f:c206:7c4 with SMTP id ffacd0b85a97d-47fc832c6c4mr185226f8f.47.1785365410194;
        Wed, 29 Jul 2026 15:50:10 -0700 (PDT)
X-Received: by 2002:a05:6000:60c:b0:47f:c206:7c4 with SMTP id ffacd0b85a97d-47fc832c6c4mr185207f8f.47.1785365409800;
        Wed, 29 Jul 2026 15:50:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e424fsm168020f8f.14.2026.07.29.15.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 15:50:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nikunj A Dadhania <nikunj@amd.com>,
	stable@vger.kernel.org,
	Chandrakanth Silveru <Chandrakanth.Silveru@amd.com>,
	Srikanth Aithal <Srikanth.Aithal@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH stable] KVM: SVM: Bump asid_generation on CPU online to avoid ASID collision after hotplug
Date: Thu, 30 Jul 2026 00:50:05 +0200
Message-ID: <20260729225006.671397-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nikunj A Dadhania <nikunj@amd.com>

[ Upstream commit 25f744ffa0c8e799e06250ce2e618367b166b0d4 ]

If a vCPU stays scheduled out (or blocked) while the last pCPU it ran
on goes through a hotplug cycle (online->offline->online), and the vCPU
then resumes execution on the same pCPU, then it is possible for it to
run with an ASID that has now been assigned to a different vCPU,
resulting in stale TLB translations being used.

svm_enable_virtualization_cpu() resets asid_generation to 1 and sets
next_asid to max_asid + 1 on every CPU online event, including hotplug
cycles.  Because next_asid starts beyond the pool boundary, the first
call to new_asid() after an online event always wraps the pool,
incrementing asid_generation to 2 and assigning ASIDs starting from
min_asid.

Consider two vCPUs from different VMs, vCPU-A pinned to CPU-X holding
asid_generation=2 and ASID=N from before the hotplug event:

  1. CPU-X goes offline and back online: asid_generation resets to 1,
     next_asid = max_asid + 1.

  2. One or more vCPUs migrate to CPU-X and call new_asid(), wrapping
     the pool and consuming ASIDs starting from min_asid.  Eventually
     vCPU-B from a different VM is assigned asid_generation=2, ASID=N
     — the same ASID that vCPU-A held before the hotplug.

  3. vCPU-A enters pre_svm_run() on CPU-X: current_vmcb->cpu is
     unchanged so the migration branch is skipped.  Its saved
     asid_generation=2 matches sd->asid_generation=2, so the generation
     check silently passes and vCPU-A continues running with ASID=N —
     the same ASID just freshly assigned to vCPU-B.

Both vCPUs from different VMs now run on CPU-X with the same ASID,
causing them to share NPT TLB entries and producing stale translations.

The collision manifests as a KVM internal error (Suberror: 1, emulation
failure).  The NPT page fault reports a faulting GPA far outside the
VM's physical memory range — a sign of stale TLB translations being
used.  KVM falls back to instruction emulation, which fails on
FPU/XSave instructions (XRSTOR, STMXCSR) that the emulator does not
implement.

Fix this by incrementing asid_generation instead of resetting it to 1
in svm_enable_virtualization_cpu().  On module load, asid_generation
starts at 0 (memset) and the increment produces 1, identical to the
old behaviour.  On subsequent hotplug cycles the generation advances
beyond any value a vCPU previously observed on this CPU, so the
generation check in pre_svm_run() reliably forces new_asid() on every
vCPU after every hotplug cycle.

Fixes: 774c47f1d78e ("[PATCH] KVM: cpu hotplug support")
Reported-by: Chandrakanth Silveru <Chandrakanth.Silveru@amd.com>
Tested-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Message-ID: <20260715063506.672432-1-nikunj@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4d2bacd00ec4..d0971685034b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -571,7 +571,12 @@ static int svm_enable_virtualization_cpu(void)
 		return r;
 
 	sd = per_cpu_ptr(&svm_data, me);
-	sd->asid_generation = 1;
+	/*
+	 * Bump the current asid_generation value to ensure any vCPU that
+	 * previously ran on this CPU sees a stale generation and is forced
+	 * to acquire a new ASID, preventing a latent ASID collision.
+	 */
+	sd->asid_generation++;
 	sd->max_asid = cpuid_ebx(SVM_CPUID_FUNC) - 1;
 	sd->next_asid = sd->max_asid + 1;
 	sd->min_asid = max_sev_asid + 1;
-- 
2.55.0

