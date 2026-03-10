Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CA23F54C7
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186551; cv=none; b=UNUvvAsJIrTGb3sgi9WLAuCEO+loP7DEU3NUDHCo91NgLVYUTqgclGSdbHzUnL0lw2UXbxyR/4vgXn0TBKR+KL5FXKxNRDnWRz9KvcRksYyvJP2J40CT7fONTq+ZpzRTBFhy2wpAEQCfWbTaf+s+mKlMRAmW0gLkWTuAE+wXulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186551; c=relaxed/simple;
	bh=4TD9pPi5TlvpvhOzVSMC/8tIlufHssTvpFKZG9MSCS8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lht7ny9UPHlzqvUReWdnlD3my5SDv20glLvkHlTZqJquhPk32qZ2jLhoo198ZJEbiuhA5qq7Rk+mCQ8HCIE5+AJTu0V0QKFhMR3NCgAxt/KH7bAwNxVjU0QxpMDjMt/crDx3oCArCSugYzrLDKyPo8OkM/0zGSXK1/GEyatAh74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nuH1AKLN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nuH1AKLN"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7385a1476aso3932370a12.2
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186550; x=1773791350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsy02nKNMThAB7RAfyDYV+cekM55MBbRNNmsTH3jOcQ=;
        b=nuH1AKLN4Qu9XnRijhhKzVf6fWwcVq2ig1WNk/pjBhLdkjzUO8VselpW/TfBEJ1LTi
         PLeIJ0YgJpsTl51cthif4lCSMN56BwVEkATIJSsnO0KOwtMadMV8lwXwKWMOE31EesAW
         e4zEPO3pNxHKxXsSIqF89LOIuUPQk5pjvx/cjZWD23BFcdz8vVNP0sySUecXQwjzyqhk
         zpiJdgt3CgVs2duoVgk28UX0luJPrXazgKwX+c9QOmvUqFJ2XPMZHrc0+V6Vc/WGuk1y
         HdNFT4kOfAwaSs9dvV9M3pgvwLHrPpEybXiFTXqBCknWtlIdUF5hD4poObXf+1nLsDIB
         PoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186550; x=1773791350;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rsy02nKNMThAB7RAfyDYV+cekM55MBbRNNmsTH3jOcQ=;
        b=e35XQAjm8+cMqCcCDPNkLBlkC5BgZHQWYrV59uD65vKZK7hkGDWCdl/4753VtODc56
         /PjJgImRzt3+mAyKnM9ohR3K0/TO7n1R3uhBNjhV6JJHPXbe/dhLlmtvqT0kybaQWPOJ
         2oBnP9hifqVSNtgVjDOmoYwQS8+mwWRfS13GzErrxvB99mtdmAjX0ghd9GLclkbj2Ynp
         kkKxBkXq+tvoFBA4GZtt38TdImdbTvGcaoJJwWyVWOp7zQL7HtCuhqzfECJjzo0kwGPV
         vQ4I3UCvxe/T/nk8I5lMTrjy0flpzwI4460JkJzNhlfp7q9v9cjhS9NV5D86p4CFZNcK
         FdDw==
X-Gm-Message-State: AOJu0Yx19ly+KVjTChKH2K2JaL3DzgjlxvOyLTubHstuSdkTOC87XcKI
	K16mGFqgb3Y3BmdtXei5vq5SRO+YdET27ubYPAwymZ2LxaWltifA6W+A3Dwfjw5fyQ4LKu0rfBM
	/FLO4Hw==
X-Received: from pgww18.prod.google.com ([2002:a05:6a02:2c92:b0:c73:7789:143c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:400f:b0:398:7b1d:87ce
 with SMTP id adf61e73a8af0-398c5f94378mr339334637.20.1773186549951; Tue, 10
 Mar 2026 16:49:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:27 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-20-seanjc@google.com>
Subject: [PATCH 19/21] KVM: SEV: use mutex guard in snp_handle_guest_req()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Carlos L=C3=B3pez <clopez@suse.de>

Simplify the error paths in snp_handle_guest_req() by using a mutex
guard, allowing early return instead of using gotos.

Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
Link: https://patch.msgid.link/20260120201013.3931334-8-clopez@suse.de
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 61347d8508f2..36a33e8ade4d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4174,12 +4174,10 @@ static int snp_handle_guest_req(struct vcpu_svm *sv=
m, gpa_t req_gpa, gpa_t resp_
 	if (!is_sev_snp_guest(&svm->vcpu))
 		return -EINVAL;
=20
-	mutex_lock(&sev->guest_req_mutex);
+	guard(mutex)(&sev->guest_req_mutex);
=20
-	if (kvm_read_guest(kvm, req_gpa, sev->guest_req_buf, PAGE_SIZE)) {
-		ret =3D -EIO;
-		goto out_unlock;
-	}
+	if (kvm_read_guest(kvm, req_gpa, sev->guest_req_buf, PAGE_SIZE))
+		return -EIO;
=20
 	data.gctx_paddr =3D __psp_pa(sev->snp_context);
 	data.req_paddr =3D __psp_pa(sev->guest_req_buf);
@@ -4192,21 +4190,16 @@ static int snp_handle_guest_req(struct vcpu_svm *sv=
m, gpa_t req_gpa, gpa_t resp_
 	 */
 	ret =3D sev_issue_cmd(kvm, SEV_CMD_SNP_GUEST_REQUEST, &data, &fw_err);
 	if (ret && !fw_err)
-		goto out_unlock;
+		return ret;
=20
-	if (kvm_write_guest(kvm, resp_gpa, sev->guest_resp_buf, PAGE_SIZE)) {
-		ret =3D -EIO;
-		goto out_unlock;
-	}
+	if (kvm_write_guest(kvm, resp_gpa, sev->guest_resp_buf, PAGE_SIZE))
+		return -EIO;
=20
 	/* No action is requested *from KVM* if there was a firmware error. */
 	svm_vmgexit_no_action(svm, SNP_GUEST_ERR(0, fw_err));
=20
-	ret =3D 1; /* resume guest */
-
-out_unlock:
-	mutex_unlock(&sev->guest_req_mutex);
-	return ret;
+	/* resume guest */
+	return 1;
 }
=20
 static int snp_req_certs_err(struct vcpu_svm *svm, u32 vmm_error)
--=20
2.53.0.473.g4a7958ca14-goog

