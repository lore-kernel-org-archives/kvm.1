Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4213AFCE3
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491172; cv=none; b=Zb9767oEeqwbvGsk+JT0pjCH4q7tWolOypOXjkWc+PoUTc6yD0sTcG4bRCHJEEMM61HgFQ4CvPyCQr51S8wm+t1mMqFD+ES2kJxBY0xZCEKWEAd795Xk1csjWIPK+krliXgysV3r97iqwUj2qOoppcoFEdGmZuM8WuwrMFTZcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491172; c=relaxed/simple;
	bh=zecYlzO38d+aZ9cl59Li0Pz6vAUQcHXyeaoBGCtqnSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gr64tdL1tUZ1pMPkoaq+hjUxpIb7ezcUaL194ldBdAkfDbl6UshWglBflknJJoXKrHCtb2MrBPmjfswRDROThVyk3MH9GqBvN+3Gl9Mprn7SPplfL5RjcbhKYi9hUUxPdg2YS9/7Q85uCz/o9jrMR4nQnzSsgW8pCCpiqAcyDvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wmX+A6Zp; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wmX+A6Zp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783491167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OakrGP+i5Wbv3La58u+R3NJ58lVHXdE6bN/zrezavE0=;
	b=wmX+A6ZpFxRMw64Ml1l/fc0Cd86wo44Jn96nIva0YbxWm87NonXwZ8SrsZMPZDyAMUgL0v
	RvakQbWthHy8UnNcM84DbHISNKZnV6hJgZBisbmYm2i9o982J89VKHSKNXvHrmzYQ0V+p/
	9hEb+8wA/U68hz3f7v8cMJOlaXwoOaM=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	armbru@redhat.com,
	eblake@redhat.com,
	kvm@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v1 0/2] accel/kvm: notify management of vCPU run errors
Date: Wed,  8 Jul 2026 14:12:18 +0800
Message-ID: <20260708061220.53507-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

Today, when a KVM vCPU exits with KVM_EXIT_INTERNAL_ERROR,
KVM_EXIT_UNKNOWN, or a failed KVM_RUN ioctl, QEMU logs to stderr and
calls vm_stop(RUN_STATE_INTERNAL_ERROR). The management layer then only
sees the derived STOP event; it cannot tell which vCPU failed nor obtain
the kernel suberror / extra data. This gap is even called out by a
FIXME in kvm_handle_internal_error().

This series adds a KVM_VCPU_ERROR QMP event, emitted before the VM is
stopped, that carries the failing vCPU (cpu-index, qom-path), an error
category (KvmVcpuErrorReason) and, for KVM_EXIT_INTERNAL_ERROR, the
kernel suberror and extra data words.

  Patch 1 defines the event and the KvmVcpuErrorReason enum in
          qapi/run-state.json.
  Patch 2 wires it up at the three unrecoverable-exit points in
          accel/kvm/kvm-all.c and removes the FIXME.

Tao Cui (2):
  qapi: add KVM_VCPU_ERROR event
  accel/kvm: emit KVM_VCPU_ERROR on unrecoverable vCPU exits

 accel/kvm/kvm-all.c | 46 +++++++++++++++++++++++++++++++++---
 qapi/run-state.json | 57 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 3 deletions(-)

-- 
2.43.0

