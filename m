Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A258BE9;
	Mon, 20 Apr 2026 02:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776652298; cv=none; b=Rhi9xct08HXXAr/mkJhwf7fzTgAxoYoEXZ8R3OYAaWgM28sxR82mMw67QpkBU151p5yqqdQikVBCC0VAfQ2uA6MrSgHtySz1BVTCtX7wg4mdNLtVvhDZGvX1W83Xs7pDC8xOzKJfsOJmVuwlRYR8iBJ+fX4mofbPkNGLaa7/iiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776652298; c=relaxed/simple;
	bh=TQwullVsUIZOqFIqtUzzuyHJAcez9ayghVBG9N4kZeI=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=nVZuMWHXb2K8nFx33IMgC++JyG5Ec8DGso3OxNqSTiooq4m6dp+WkVu2ZK6QM+KR0ygTmEeBh5AqQC7LIl5kjDavzuLYq6oAyOklPqM93rp8swPCfFNshsOwPHB3lH/21AueIUU6Pu7VXOhuOZG91m0d8a7cIifEizgBTJsxMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=arBOEobh; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="arBOEobh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1776652286; bh=wxVdb/Eq8JrZEGitcjcXcDQR5qqONiuRwjZdYnagZZY=;
	h=Date:From:To:Cc:Subject;
	b=arBOEobhmoLfNRUSibLbPtGA/DiLcE7uNXi35uC0xi7wHVa+rPna5RhbRn+uqIuqu
	 mzzTGcOpFXjpjnZ6LBQSsq0qSLJjjQDPprQYxuRYU8Y42n3RGidN1d9+o8Gl41Ee83
	 eVY+gMtYge3vjhsPlwVqYn0102X6UhFm2J0wfHlM=
Received: from zh-pc ([116.128.244.169])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 7D72DC58; Mon, 20 Apr 2026 10:31:23 +0800
X-QQ-mid: xmsmtpt1776652283tmv6052s8
Message-ID: <tencent_91386147982D1B2901B22D2423D4643AC90A@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uknEXpEyu2ikjBdlIRHNiNW9MYdVfIicuZNyNNEbldrkSIPfMvY
	 2wJQZtZh+F7Q9UvbiYRtfOYmrU0/Ot8OFpGvqFbWdH/3Qlw5zB+q8/P1k4NN0v7wo+9qAJuPze4+
	 /Sn6F4Fn77WFL3QAc8440vhV/L+h5Eckn9MaB4vdUNR9UjmoP9y/FQkqDLTATM5O9//HCXFE8RUW
	 pYZ0Xy+yDxKv5He8sXF94kzXMOd0oKWNtJtXOKfGHsTXlbzU4kjtoj1BwyoIPKws87dOPT9zt4i+
	 YCOL+LhI/noORJGyx4QYOJSJ7l/JgXVWBMFvvnm0XttO8IgFwa/0KwWEX+NiASqwZtjsMtx7Mvfr
	 JiBfqN7XZUCN7WwIxcW6HHjaYc62MTTnYscY4KypmJBmmw/eDLM/0/Q6++VVBp1dyEGkIW9HfN0D
	 /X369gvVZAVjQx2Av/Bd+ulXYqFpQ5LcIO3PjX8AJo3YrQ08pBy2xfim4SHFbFJIlu0fFdzenALU
	 Su0KklhpKrGkvY3Kjn+NhIBAK7TuurHipkpGKlGLlLn3ZT/EAC7xuaa/DU3J5btSu6DlCBww9Paw
	 UXjShfkHOE1P3+rs2qDIB0LThUyzwmFi9w5Xg9kxaBvWjYYV37KwIoxNqvfJ/qGFwA/5awsJuJ7x
	 2FBSXQRDE4z1l6wmTKMb0M9KSnwf7szzcLkc+fZAZTL3x4xpFRwJAFOxNefuwB1pXChGjANMkRRw
	 M4MhISawppWWZxW34BfpKEHIC8mOVhwfSbSX0V0vjQB7y2r2Dt/wsZ5cjIm8KjJCZfPAtx/bMxJV
	 t+J8PDSVTc4STYjCVVE+4kYprEBgTD4k6eg+tE1B5AbnGNjhlE/PToM245fSBbQyT6bjmyU98e+q
	 somCswrExwTRDyTsA7S1TV3LMULU4b3OmyqID2jYX78BmgcHwKNLxqu5k8X5uw4Q1Uj8PgpP++4R
	 hBQlsVmYDaK2/2gjwP7w9gbHk0jqJlGCyylWukMUz5CEd2p/qiJExzHbkFVqcOfMgJenlJsWopKy
	 iq3mQSZKP6NlUyZtJYk19bpzXO2HaSe4CWUJVJ0K9N1ImyRQzXbSmFK0Ix3N8BA8eM/p8702HStH
	 y61qJb
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
Date: Mon, 20 Apr 2026 10:31:22 +0800
From: zhanghao <76824143@qq.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: Dynamically scale directed-yield retries in
 kvm_vcpu_on_spin()
X-OQ-MSGID: <20260420023122.GA49894@zh-pc>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

kvm_vcpu_on_spin() currently uses a fixed retry budget (3) when
kvm_vcpu_yield_to() returns a negative value. That fixed limit is
often too small on large VMs, where candidate selection is more likely
to race with scheduler state and transiently fail.

Replace the constant retry count with a vCPU-count-based budget:

  try = min(nr_vcpus - 1, 8);

This keeps retries bounded while allowing more opportunities to find a
yieldable target as VM size grows. Small VMs keep near-identical
behavior, while larger VMs get a better chance of making directed-yield
progress under contention.

No functional change is intended beyond retry-budget tuning.

Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 virt/kvm/kvm_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 89489996fbc1..cbe53cea10a3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3961,12 +3961,14 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 	int nr_vcpus, start, i, idx, yielded;
 	struct kvm *kvm = me->kvm;
 	struct kvm_vcpu *vcpu;
-	int try = 3;
+	int try = 0;
 
 	nr_vcpus = atomic_read(&kvm->online_vcpus);
 	if (nr_vcpus < 2)
 		return;
 
+	try = min(nr_vcpus - 1, 8);
+
 	/* Pairs with the smp_wmb() in kvm_vm_ioctl_create_vcpu(). */
 	smp_rmb();
 

base-commit: c1f49dea2b8f335813d3b348fd39117fb8efb428
-- 
2.25.1

