Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0456C469839
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344794; cv=none; b=g/8cxPDvYCHujPOrAifb4oYuG+2yB25ESsdxxSKhrDsGysJVK5pod7xTgBkiF0FBU8kGFfO2zoZNpIgO7bzBF98dgxV6TNrRC53jPx/Mh1ch7Y/J17qKToWlPZEFh58An+gsGWqyQVjrfWF4Mx4OX53Kb/JJOUM61ovhADwXgNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344794; c=relaxed/simple;
	bh=tsiOlAUa96Yb2zXENGGsMr86rnfZCA9ALJ7FgQ6u+oU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ku6Xoi2a/A7oTe1OFSPqsT3XvIXXgRADBtt/7xthanLQGqPzDYPGqo2W9bZ3jUfwZMXrf6+dSWTathaFtpjuQVJ7e7dVC3r0FKBljGcGsZvewQM7QMduqQdmvhsN8HDhlwETFGpcII3qo7xGM/9+fXvkAWkb6SASDkH95XxdDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I3KzD3y6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I3KzD3y6"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1c26d7e951so169669166b.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785344790; x=1785949590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JUjgOR7a0LIRa7JTwKXaksAfk4KfPx7m8MrD3Mnq65c=;
        b=I3KzD3y61JpwzMdgNytyKg2gr5ETKNNPk9/kamMPvTkwxTkJwgJREJprzFIV+MHsop
         0gg/PwEuTte4k1pp3b9KlYexbjY3WQv3u/J7cADDYJZfKEU+E4or0Q5mHpuH3MHqwLo6
         KSCqiU2RIl90BnFWXDOJlP8xV2o6uatXiTRNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344790; x=1785949590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JUjgOR7a0LIRa7JTwKXaksAfk4KfPx7m8MrD3Mnq65c=;
        b=c3/NGg7cRL0KZTPWzMx+Mce+agaaJH1WvMMd6mlVFgwQWl/xefubUZ/vF0o4BWAWh0
         zxWVcbq/0gFFwd6boJ65uAe4ku2422C30Pszdo8JFvCUL3EFc+eXsz6Zd1jnH933VDej
         SwBZr5DwtnTtjI6UH8QQRI/MjVFtu2QhpXrEra7IbcwPBUy29r09SUa5XzTpoLoEElIy
         owaDUvfnwAHXaPByLXJz86BMGTDBa6A1lIPa0vjrycwnOnsPMfOy6lknm0ubIZpNJN9S
         yWtvMcRi1k/hDsIdIfPNZjfYFKsOpUDICRmEkh1QhYvJ8hBgIBytkwRWBnx+EzvPyuAd
         SPKg==
X-Forwarded-Encrypted: i=1; AHgh+RrnU+nCfx+vRnsqdmGadKnMqfLGJ6RhsK8rTxOmiVJc6TN5XvGC86oiKsT5ud1cSpiB2K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzQLp8zA0QUpp4z8T+lFxbVmMhLheH9gSCmMo4mgof9ZTrqmkG
	mhnNvB0dWrhdd4jwdS5mreXKva+0eJBd44sLV5ssXA7gwmtoKO7WSVa4v9mlvboDPA==
X-Gm-Gg: AR+sD13piwDcJsVP342Yav19udBHXA+bWedCR08lODNoPFAOSVMn289RiFpurUExJqb
	4118KIUpu7Ijub5Uy08/XyzyREWvhYgegHbMfyvKkFsEPbZxNV3rH5H8Wq9A3gO7yc//6IsZhuT
	+QgPyKOaYR4kJI6tM3NMNii0yOAwZ0hLqhhXUxk0IA1GOOmA5Vanc8TNccuNrg68uiqBYU2n5V5
	59QcFAoF8I/FtalzaGljiDnVk7mI5ZpJr+Kv53OHJhc8xtZtNai/B7CIOX+MBeFu3Q3I9+tCzMy
	ydwUE7a+it3npL60pujl66PV+aYqgXIHkab7peJgXRREq5BZ7ptpUlkm6FR4pty/CxL/qIeLPw0
	AexQzp9nFHs0go6Dnrxw8pMk5GErzhSQqs0xaPoIw91ALjklFQuJgINzbSpbD+awqAiMlGp9nhZ
	TwzL6t364St0vdOAsCPggxv2Q3JcQd/YskLfKUqFXv9eFm2Ls27txWwLiQ8gxgTOhfFZRnoBZnK
	CfdmCcqmMJX2SgqH1ZplBSy1hqKVFy++dMH0DazTss/Pp3MXCdClug=
X-Received: by 2002:a17:907:9487:b0:c12:6584:c1 with SMTP id a640c23a62f3a-c1f7221f3aemr422167466b.40.1785344790234;
        Wed, 29 Jul 2026 10:06:30 -0700 (PDT)
Received: from dmaluka.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83c686a8sm142753566b.4.2026.07.29.10.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:06:29 -0700 (PDT)
From: Dmytro Maluka <dmaluka@chromium.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Naveen N Rao <naveen@kernel.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH v2 0/2] KVM: VMX: Fix IPIv use-after-free + improve checking duplicate vcpu_id
Date: Wed, 29 Jul 2026 17:06:19 +0000
Message-ID: <20260729170621.308809-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vCPU creation in kvm_vm_ioctl_create_vcpu() may fail after
kvm_arch_vcpu_create() -> vmx_vcpu_create() already succeeded. In such
case kvm_vm_ioctl_create_vcpu() destroys the newly created vCPU in the
failure path. However, that leaves a side effect: the IPIv pid_table
entry remains configured with this vCPU's pi_desc address. As a result,
when another vCPU sends an IPI to the APIC ID of this failed-to-create
vCPU, it will cause HW to write to this (freed!) pi_desc memory.

The straightforward way to fix this is to clear the pid_table entry in
vmx_vcpu_free(), which is what patch 2 in this series does.

But that requires addressing a related meta-issue first: if userspace
tries to create a vCPU with the same vcpu_id as an existing one,
kvm_vm_ioctl_create_vcpu() checks for that and fails with -EEXIST only
after it already created the vCPU via kvm_arch_vcpu_create(). As a
result, clearing the pid_table entry in the vmx_vcpu_free() in the
failure path would clear the pid_table entry for that already existing
good vCPU, i.e. effectively disable IPIv for that vCPU.

For this reason, the v1 patch [1] addressed the IPIv issue by postponing
the pid_table entry setup until kvm_arch_vcpu_postcreate() when we are
sure that the vCPU creation succeeded, instead of clearing it when
destroying the vCPU.

However, as pointed out by Sean [2], insufficient validation of vcpu_id
before calling kvm_arch_vcpu_create() is a potential source of a whole
class of similar issues, so it's better to fix this meta-issue once and
for all. Another concern about the v1 approach is that initializing vCPU
state in vcpu_postcreate, after the vCPU is already reachable, is
generally tricky.

So patch 1 in this series moves checking for duplicated vcpu_id in
kvm_vm_ioctl_create_vcpu() earlier, before creating the vCPU. To do that
without races, it introduces the kvm->vcpu_ids bitmap (see patch 1
description for the details). It is a slightly adjusted version of
Sean's bitmap patch from [2].

P.S. Note that the same IPIv use-after-free issue exists on SVM as well,
as pointed out by sashiko and confirmed by Naveen [3]. This remains to
be fixed. (Supposedly it is as trivial to fix as for VMX, but I'll leave
that to someone who's familiar with that and has AMD hardware.)

[1] https://lore.kernel.org/kvm/20260716160801.3155582-1-dmaluka@chromium.org/
[2] https://lore.kernel.org/kvm/al6eg7C-2sDBEAFD@google.com/
[3] https://lore.kernel.org/kvm/al4rNqpBYy8FGKPw@blrnaveerao1/

Dmytro Maluka (2):
  KVM: Check for duplicate vcpu_id as early as possible
  KVM: VMX: Fix stale PID-pointer table entry left after vCPU free

 arch/x86/kvm/vmx/vmx.c   | 3 +++
 include/linux/kvm_host.h | 1 +
 virt/kvm/kvm_main.c      | 9 ++++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.55.0.508.g3f0d502094-goog

