Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5469437D11F
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 06:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491180; cv=none; b=pmtUpWvuPLYbHUI46gGI5DnsQ7Dbq9zCA2XaWSXjBZ+Xhx0rQ/3nGE4JT9749rMyYM5QUkxNYJOEzq90yUJmgTvgAVpq7TYzPBuaVQbzBr6bEPGUwhHyd0QNczkKHdnZVj1O/3BdcVlQqhzAoyl1ADoz5SjNC94CD12SeGQ4H1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491180; c=relaxed/simple;
	bh=Mu2h4hCkRCzgVMZGbRRj7RmmPaUESHq1AHDDSsL9zyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xd/iGekSu8AVcjCpHw3mDVdKqFI4+zxlh7TObK5OItLf6QYNfdOKzfRiNxSp+zTT9bbDpz4dcyQpCiqVrs7o99w+WJNCGZAG92fZyO4OQa/M+FjY+yO/IV/bvokTrOI4lGlrTZSXg9Nsj+Gg0HsVwdGPCdXKQ306iIb0Y7Yj3sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RviQb1VY; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RviQb1VY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783491177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=353VxZ9MzLkqwPCPkr6Wvy1knHKPDmxuC2cl5nDdP9A=;
	b=RviQb1VYf6Km+EZCUGuAc4tjx1K5DxQNyyzGEtAd9ElKfe3YvjCrMEOZ569JpklouBDnTM
	KEfdbmpBJwQy5E70dr+K763ynamG//vkjnSG1itZZ4i4ia8y/bwc26AMlBzoVKA9/nt4su
	9wngPEfYUmG4A7htJeFFRr8rB1qATCc=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	armbru@redhat.com,
	eblake@redhat.com,
	kvm@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v1 1/2] qapi: add KVM_VCPU_ERROR event
Date: Wed,  8 Jul 2026 14:12:19 +0800
Message-ID: <20260708061220.53507-2-cui.tao@linux.dev>
In-Reply-To: <20260708061220.53507-1-cui.tao@linux.dev>
References: <20260708061220.53507-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

When a KVM vCPU exits with an unrecoverable error (KVM_EXIT_INTERNAL_ERROR,
KVM_EXIT_UNKNOWN, or a failed KVM_RUN ioctl), QEMU currently only logs to
stderr and stops the VM with run state "internal-error". The management
layer must infer what happened from the subsequent STOP event, with no
indication of which vCPU failed or why.

Add a KVM_VCPU_ERROR event, emitted before the VM is stopped, that carries
the failing vCPU (cpu-index, qom-path), an error category
(KvmVcpuErrorReason) and, for KVM_EXIT_INTERNAL_ERROR, the kernel suberror
and extra data words.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 qapi/run-state.json | 57 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index a5771ad468..c9993ad9ac 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -732,6 +732,63 @@
   'data': { 'action-required': 'bool',
             'recursive': 'bool'} }
 
+##
+# @KvmVcpuErrorReason:
+#
+# Categorizes a KVM vCPU run error reported through @KVM_VCPU_ERROR.
+#
+# @ioctl-failed: the KVM_RUN ioctl failed; see stderr for the errno.
+#
+# @unknown: KVM_EXIT_UNKNOWN; the hardware exit reason is logged to
+#     stderr.
+#
+# @internal-error: KVM_EXIT_INTERNAL_ERROR; see @suberror and
+#     @exit-data for details.
+#
+# Since: 11.2
+##
+{ 'enum': 'KvmVcpuErrorReason',
+  'data': [ 'ioctl-failed', 'unknown', 'internal-error' ] }
+
+##
+# @KVM_VCPU_ERROR:
+#
+# Emitted when a KVM vCPU exits with an unrecoverable error, before
+# the VM is stopped with run state ``internal-error``.  Lets the
+# management layer learn which vCPU failed and why, instead of
+# inferring it from the subsequent STOP event.
+#
+# @cpu-index: index of the vCPU that failed.
+#
+# @qom-path: the QOM path of the vCPU that failed.
+#
+# @reason: error category.
+#
+# @suberror: KVM internal suberror.  Present only when @reason is
+#     @internal-error.
+#
+# @exit-data: extra KVM data words.  Present only when @reason is
+#     @internal-error and the kernel provided extra data.
+#
+# Since: 11.2
+#
+# .. qmp-example::
+#
+#     <- { "event": "KVM_VCPU_ERROR",
+#          "data": { "cpu-index": 0,
+#                    "qom-path": "/machine/unattached/device[0]",
+#                    "reason": "internal-error",
+#                    "suberror": 1,
+#                    "exit-data": [ 0 ] },
+#          "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+##
+{ 'event': 'KVM_VCPU_ERROR',
+  'data': { 'cpu-index': 'int',
+            'qom-path': 'str',
+            'reason': 'KvmVcpuErrorReason',
+            '*suberror': 'int',
+            '*exit-data': ['uint64'] } }
+
 ##
 # @NotifyVmexitOption:
 #
-- 
2.43.0

