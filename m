Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22086345CA3
	for <kvm@vger.kernel.org>; Wed,  4 Feb 2026 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224512; cv=none; b=uocIMFrf9CbtvCo6MlW8OM7uMq6K/5mt3VbSVNGh3A/2vqqGsV2Dfb+Y4goUISlUT0wwxxmyxF3qAVja7K/XM6yFZOp7KTeoUnkvq4gjsiJDcCoGQ67XxdO2Jy1OOeR6OpvxkE0xjMDkJGq5GgMnSbYqij1/1Mtob/5dJLKg+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224512; c=relaxed/simple;
	bh=zXDPKG0QFJsKzukroTUc1zROWLfgrby9a/XPbYdq2Kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h31A4TikdQm9WbX9TbsDHs5st9JChtt5xfH77g4DaWrggCvRQfronzAIPfH23qGmEvHjy6LEAl+8w/ggnMTVt9D8Fdo7DgWkCOQRV9OzTif919TPOaemAA+eTILe0jlcb4mzvyNL92amh5f5zDk61zw333J1UCRPanmC0GRRVSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1gEiFnzK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1gEiFnzK"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a92a3f5de9so222885ad.2
        for <kvm@vger.kernel.org>; Wed, 04 Feb 2026 09:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770224511; x=1770829311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8WMOpnBzK2vdwNqXg8ywHrddXOjiSQhU2eArBbp1I0w=;
        b=1gEiFnzKmQEhPUmwJCMQmaDM03R5jyF6v9F0sD6SDRzKlikO3ydsLq3WITpsI85I7S
         vSCjqtB9VgP0bleIeXV9XdwqDmteFMBOn0F45tgNT+qasiE2VIsKdRMJGqYJ7ZRL9FvJ
         13eR0qn6mpF5YWBDv+HrmnHRizLLyStDxod5SJ95HNxP1qhf/ZQNU1Vksq9zgWBbvIIp
         XF57wpnAT8B4igKTsE/I93W8eoJNSs4PwYs2BA5J++x/RsY7w9rrfbXfPVuqoNIwpNPL
         IOgzjs0WQ8UZ3iN78aVoVTfEjb+FPO84SfLvjJenztEFx5YZeEXvgT7MJPKexJ/dIulC
         bHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770224511; x=1770829311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WMOpnBzK2vdwNqXg8ywHrddXOjiSQhU2eArBbp1I0w=;
        b=jK37tDXSqLnHF4coIt2SjCvEgyXRAfOflY4ZA2+ZWeAqsXyO14WX4aMbc2Nwk8Vtl8
         r33apn7jAp0NbGycSXQsjGmr8+7uXwOqAteXUaq36yQMxd5SQV/sop0WkBUo/tvlnEZ6
         ZrFuqdI2Wa3riMTb9fTUF6ZADZg2BVPvnvHOnRmrARAt9a/wpoFv/NhsHYgXn/giRvYY
         l3xtvv5ACUahjdHCMo8SzDb/lECkGRNSRR0/zUYxWjXaJH2xBV51+ddOLIlbehRYjZ7u
         2oOTfzb8XGClJsuNM0aCaDQaStgJeQZO5p+TXmOQ+F4XIyk34GPdWb9pgX6RiQuDm1Dw
         WdKQ==
X-Gm-Message-State: AOJu0YxT/gtdOSy4rML+t6SSfTyUkoSrLFAy6GDy3h0kMnE2jh132Wf0
	hSd9dVcNgvxzpP1S5haFEbKDFMXHs5d1gmFSOneDejmQXCOwvOzsDeRm/A4E6UKR4Ni/9m69oyI
	kL+swZ61zcyg+x4kQaFyyw6s1Pw==
X-Received: from pjbsw15.prod.google.com ([2002:a17:90b:2c8f:b0:340:bd8e:458f])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c0e:b0:34a:b8fc:f1d1 with SMTP id 98e67ed59e1d1-354871a9567mr3113217a91.24.1770224511283;
 Wed, 04 Feb 2026 09:01:51 -0800 (PST)
Date: Wed,  4 Feb 2026 09:01:44 -0800
In-Reply-To: <697d115a.050a0220.1d61ec.0004.GAE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <697d115a.050a0220.1d61ec.0004.GAE@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260204170144.2904483-1-ackerleytng@google.com>
Subject: [PATCH] KVM: guest_memfd: Disable VMA merging with VM_DONTEXPAND
From: Ackerley Tng <ackerleytng@google.com>
To: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/virt/kvm/kvm.git next

guest_memfd VMAs don't need to be merged, especially now, since guest_memfd
only supports PAGE_SIZE folios.

Set VM_DONTEXPAND on guest_memfd VMAs.

In addition, this disables khugepaged from operating on guest_memfd folios,
which may result in unintended merging of guest_memfd folios.

Change-Id: I5867edcb66b075b54b25260afd22a198aee76df1
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index fdaea3422c30..3d4ac461c28b 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -480,6 +480,12 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 		return -EINVAL;
 	}

+	/*
+	 * Disable VMA merging - guest_memfd VMAs should be
+	 * static. This also stops khugepaged from operating on
+	 * guest_memfd VMAs and folios.
+	 */
+	vm_flags_set(vma, VM_DONTEXPAND);
 	vma->vm_ops = &kvm_gmem_vm_ops;

 	return 0;
--
2.53.0.rc2.204.g2597b5adb4-goog
