Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F58C3E9F84
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174266; cv=none; b=ccrcnGP808exdLN+OTHCobGsuV15VF0NmIw7/nmggJqmlI0Vg0pwlPMGsPvUL7xe4tFOM5UQX4251Dh0bxCP/r6LWYaeWZFJ6Lyv0FM/jOBUnuJ2Lt4u1BMsEOYCsoVV5bWkzP58Igk8OdZX40mS5NqazE4fnA6cOyLJy7XxaW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174266; c=relaxed/simple;
	bh=XzfjV0NwKwYFZsCPkm9GQbhIVKJ1rr5+J23oLRZx2CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGiDKBvGXC8Mk2KwL4x39KNE4nD86HeUCBHgljTgdMbTJhNeNo5lqpPVMeleLeQBpUScYju6uaZcJs86FnJ89M5Rr5p9kMOvnfx51ubdwSZ8A+6Zf3I10KJUyD8CqGAMELZ6/RjgNfw6VzdJdS/e6zA3N4YQonFpa0sVaeKL0N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cn1AjjU2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kNxpTrwY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cn1AjjU2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kNxpTrwY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773174264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TGyObaOA+0rXaSG+XOwiWbo5MYOrwO/NaEY5gkjsyg=;
	b=cn1AjjU2nLIH6KVFkAjtpPpY5wBwHVs1RDF8z4mJyFnmstxT+5S3+e6kMAPLdWli88ojxc
	8kJGIWR4wH/rmf62Gp0xAySZHkUXQnfqYLkgzQKDTv5aNMYPUe6y5nhHAnkBn3B6YA6UXT
	h47AIG02hXHnlgBRjVQWkB72FjUdWXk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-bBgoWbP7MzCd46eRVDNXFQ-1; Tue, 10 Mar 2026 16:24:22 -0400
X-MC-Unique: bBgoWbP7MzCd46eRVDNXFQ-1
X-Mimecast-MFC-AGG-ID: bBgoWbP7MzCd46eRVDNXFQ_1773174262
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so105958955e9.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 13:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773174261; x=1773779061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TGyObaOA+0rXaSG+XOwiWbo5MYOrwO/NaEY5gkjsyg=;
        b=kNxpTrwYlxYQ0WloV7oTR1vx5LiwnzL0JXw6B7/FFxYfI/i7ubT75+DXlvuEmpMebb
         Ef6uDtFyK7YTYEztXKMt+9ioC/ZIPMm233QM7v8h8owJaas+DP/W38EFWNFZ6QVYFrE4
         C9NUfXAvtQN3D4+4MnrLiFxp6elY9mJyWn6L0xf21XntXasW+nrqszoir5PM9Fo947kU
         BrDeoVv+9htAd1IZ/G92UqZsEh2GUGehZt4ZfpenQR7V5l0nJ+NCG7pXOlWgZYwHIcE9
         GdrFNCoTcrEhY0hXrb5qoxa9p2fyifyDPdHxoI5bJqpjL/BZ31qJz1tW9qp0l8EFys5p
         BJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773174261; x=1773779061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8TGyObaOA+0rXaSG+XOwiWbo5MYOrwO/NaEY5gkjsyg=;
        b=ahQvaCKXGZ21nTgC5xNrupHUMrUfU6xMZwVGgQVjLsCxqrvvz4hFPGYinEChX/dHWX
         mzr9BYBignMvU/P8h+qBtCGGqvvr4iyV8ZWKHiy3wXEvBHr6f0koq7PftLVYUU2mwFEy
         7fDiQ/Lgl3ZMT3VFfaCbDZsXcf+Wt0SLcNW9slf60mTPJcNak58xQ4pGR+WJIhj7TnIL
         zQ/GrbJNU7vFr0Y0DXbjMoPpfiVi8+kOmgCLOe7pJ2wGGAuDYLGmd9flWjzXwp3Q4Wj8
         cqVQ3N4UHs7DC3IleQeCmUSlLta9zfWrdv2/xDMQWl5LU5ISfOoUkm9KwjG1CopuQye6
         prng==
X-Forwarded-Encrypted: i=1; AJvYcCWRj8Aey9nDGe74x7uumRHyx4EmpGyqJBz99wzqOSEFp3oa4+UjYdBq2YX2DIpt8ChLO04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3zzcrMiqYW/3JD1hs2MDORsYEckZ4hUxwQl7q/U7e9eRN8yN
	djdH+mvMtFXcSV+br8i28+mJMI9lRX4/8Dkd9lBQU2wEgpFxMdfFA4MUOurmrEY4C2w6Q+l8ibf
	Ib+sqVHZNOmGaMTtuI1NCrDP6ogwzPQm4wvLQUjY2JkB+TA2Z6kgOgg==
X-Gm-Gg: ATEYQzxWPUmD7YOjLRJJUwOkQPWxi1i0LhDxESNY4wZ9uT0Von1FOqFiEiEB7hncdEd
	LwUc4PW1UC0n1UizbsZzdZgCD5DM9sczGvrNBYYXxm9y7t4RbnrgQVjN4w7keUkCxkX9RHCqR48
	gWRHsuewbUsfzxxwVTywAeWLabmJbNuMHi7ANL42Lnc5UN4IWSe0j0nplNt2cO/1AybXGY6BubF
	jG/eZPINq1eAO1rd6ysszzc31soaeMXnfpoLi5GeKYL3TAkdVW87iZIlIB6rBQ6xpBm4V8Gpl1y
	v7J6uMHOJarm+EnOSnEWWQOkhu2l2GaQi4fdHUBJsijv1YG9CAZ0TKp+XLGN7Op7zXrQbC9VvTs
	7kemNyvHsAatd2wjnsSo+DMJaFyi7j+8oMZUtwOcoOUIDF3K1v8tX3Ska54VjWSB/3mFRfCYoLY
	WZAgfqSmdyOU9anf6Foc6L9Y7NXJU=
X-Received: by 2002:a05:600c:1d16:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-4854b0a6fcamr2153815e9.6.1773174261640;
        Tue, 10 Mar 2026 13:24:21 -0700 (PDT)
X-Received: by 2002:a05:600c:1d16:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-4854b0a6fcamr2153445e9.6.1773174261198;
        Tue, 10 Mar 2026 13:24:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0cc00asm1231095e9.7.2026.03.10.13.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:24:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	xinyang@anthropic.com,
	stable@vger.kernel.org
Subject: [PATCH 2/5] KVM: SVM: check validity of VMCB when returning from SMM
Date: Tue, 10 Mar 2026 21:24:11 +0100
Message-ID: <20260310202414.406078-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310202414.406078-1-pbonzini@redhat.com>
References: <20260310202414.406078-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VMCB12 is stored in guest memory and can be mangled while in SMM; it
is then reloaded by svm_leave_smm(), but it is not checked again for
validity.

Move the check code out of vmx_set_nested_state()
(the other "not a VMLAUNCH/VMRESUME" path that emulates a nested vmentry)
and reuse it in svm_leave_smm().

Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 12 ++++++++++--
 arch/x86/kvm/svm/svm.c    |  4 ++++
 arch/x86/kvm/svm/svm.h    |  1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 7b61124051a7..de9906adb73b 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -419,6 +419,15 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu)
 	return __nested_vmcb_check_controls(vcpu, ctl);
 }
 
+int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
+{
+	if (!nested_vmcb_check_save(vcpu) ||
+	    !nested_vmcb_check_controls(vcpu))
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * If a feature is not advertised to L1, clear the corresponding vmcb12
  * intercept.
@@ -1034,8 +1043,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
 	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
 
-	if (!nested_vmcb_check_save(vcpu) ||
-	    !nested_vmcb_check_controls(vcpu)) {
+	if (nested_svm_check_cached_vmcb12(vcpu) < 0) {
 		vmcb12->control.exit_code    = SVM_EXIT_ERR;
 		vmcb12->control.exit_info_1  = 0;
 		vmcb12->control.exit_info_2  = 0;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 477fda63653b..95495048902c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4890,6 +4890,10 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	vmcb12 = map.hva;
 	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
 	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
+
+	if (nested_svm_check_cached_vmcb12(vcpu) < 0)
+		goto unmap_save;
+
 	ret = enter_svm_guest_mode(vcpu, smram64->svm_guest_vmcb_gpa, vmcb12, false);
 
 	if (ret)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ebd7b36b1ceb..6942e6b0eda6 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -797,6 +797,7 @@ static inline int nested_svm_simple_vmexit(struct vcpu_svm *svm, u32 exit_code)
 
 int nested_svm_exit_handled(struct vcpu_svm *svm);
 int nested_svm_check_permissions(struct kvm_vcpu *vcpu);
+int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu);
 int nested_svm_check_exception(struct vcpu_svm *svm, unsigned nr,
 			       bool has_error_code, u32 error_code);
 int nested_svm_exit_special(struct vcpu_svm *svm);
-- 
2.53.0

